import SwiftUI
import UIKit
import AVFoundation
import CoreML
import Vision

// MARK: - Adding Camera Functionality
struct CameraView: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera
        picker.allowsEditing = false
        picker.cameraDevice = .rear
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: CameraView
        
        init(_ parent: CameraView) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

// MARK: - Apple cameara access
func checkCameraAccess(completion: @escaping (Bool) -> Void) {
    switch AVCaptureDevice.authorizationStatus(for: .video) {
    case .authorized:
        completion(true)
    case .notDetermined:
        AVCaptureDevice.requestAccess(for: .video) { granted in
            DispatchQueue.main.async {
                completion(granted)
            }
        }
    case .denied, .restricted:
        completion(false)
    @unknown default:
        completion(false)
    }
}

// MARK: - Main
struct ContentView: View {
    @State private var isShowingCamera = false
    @State private var scannedImage: UIImage?
    @State private var isShowingResults = false
    @State private var identifiedPlant: Plant?
    @State private var isLoading = false
    
//adding the model.
    private let plantModel: VNCoreMLModel? = {
        do {
            let config = MLModelConfiguration()
            let model = try FloraNest_Large_Model(configuration: config).model
            return try VNCoreMLModel(for: model)
        } catch {
            print("Model load error: \(error)")
            return nil
        }
    }()
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background image
                Image("MainHome")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                // Logo and Buttons
                VStack {
                    Spacer()
                    Text("FloraNest.")
                        .font(Font.custom("Fraunces", size: 50))
                        .foregroundColor(.white)
                    Spacer()
                    
                    // Plant Button and Image Button
                    HStack(spacing: 50) {
                        // Scan Plant Button
                        Button(action: {
                            checkCameraAccess { granted in
                                if granted {
                                    if UIImagePickerController.isSourceTypeAvailable(.camera) {
                                        isShowingCamera = true
                                    } else {
                                        print("Camera not available")
                                    }
                                } else {
                                    print("Camera access denied")
                                }
                            }
                        }) {
                            Text("Scan a plant")
                                .font(.headline)
                .foregroundColor(.black)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(60)
                        }
                        .sheet(isPresented: $isShowingCamera, onDismiss: {
                            if scannedImage != nil {
                                identifyPlant(image: scannedImage!)
                            }
                        }) {
                            CameraView(selectedImage: $scannedImage)
                        }
                        
                        // My Plants Button
                        NavigationLink(destination: MyPlants().navigationBarBackButtonHidden(true)) {
                            Image("BonsaiHomeBtn")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                        }
                    }
                    .padding(.bottom, 18)
                    .padding(.leading, 95)
                }
                
                // Navigation to Results
                NavigationLink(
                    destination: PlantResultsView(plant: identifiedPlant, image: scannedImage)
                        .navigationBarBackButtonHidden(true),
                    isActive: $isShowingResults
                ) { EmptyView() }
                
                if isLoading {
                    ProgressView()
                        .scaleEffect(2)
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                }
            }
        }
    }
    
    private func identifyPlant(image: UIImage) {
        guard let model = plantModel else {
            print("Model not loaded") // if model does not load
            return
        }
        
        isLoading = true
        
        DispatchQueue.global(qos: .userInitiated).async {
            let request = VNCoreMLRequest(model: model) { request, error in
                DispatchQueue.main.async {
                    isLoading = false
                    
                    if let error = error {
                        print("Identification error: \(error)")
                        return
                    }
                    
                    guard let results = request.results as? [VNClassificationObservation],
                          let topResult = results.first else {
                        print("No results")
                        return
                    }
                    
                    identifiedPlant = Plant(
                        name: topResult.identifier,
                        confidence: topResult.confidence,
                        description: getPlantDescription(for: topResult.identifier),
                        image: image
                    )
                    
                    isShowingResults = true
                }
            }
            
            if let ciImage = CIImage(image: image) {
                let handler = VNImageRequestHandler(ciImage: ciImage)
                do {
                    try handler.perform([request])
                } catch {
                    DispatchQueue.main.async {
                        isLoading = false
                        print("Failed to perform request: \(error)")
                    }
                }
            }
        }
    }
    
    private func getPlantDescription(for plantName: String) -> String {
   
        return "This is a \(plantName). (add plant description and add model !!!)"
        

    }
}

struct Plant: Identifiable {
    let id = UUID()
    let name: String
    let confidence: Float
    let description: String
    let image: UIImage?
}

struct PlantResultsView: View {
    let plant: Plant?
    let image: UIImage?
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("MainHome")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .center, spacing: 20) {
                        Spacer(minLength: 20)
                        
                        if let image = image {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 300) // output box size
                                .cornerRadius(12)
                        }
                        
                        if let plant = plant {
                            VStack(alignment: .leading, spacing: 10) {
                                Text(plant.name.capitalized)
                                    .font(Font.custom("Fraunces", size: 30))
                                
                                Text("Confidence: \(String(format: "%.1f", plant.confidence * 100))%")
                                    .font(Font.custom("Fraunces", size: 18))
                                    .foregroundColor(.secondary)
                                
                                Divider()
                                
                                Text(plant.description)
                                    .font(Font.custom("Fraunces", size: 16))
                            }
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(12)
                            .frame(maxWidth: 300)
                        } else {
                            Text("No plant data available.")
                                .font(.title2)
                                .foregroundColor(.gray)
                                .padding()
                        }
                        
                        Spacer()
                        
                        HStack {
                            // Learn More Button
                            NavigationLink(destination: ContentView()) {
                                Text("Home")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(60)
                                    .frame(maxWidth: 200)
                            }
                            
                            // Home Button
                            NavigationLink(destination: PlantFeedback().navigationBarBackButtonHidden(false)) {
                                Text("Learn More")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(60)
                                    .frame(maxWidth: 200)
                            }
                        }
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .top)
                    }
                }
            }
        }
    }
    
}

    
    // Preview
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }


