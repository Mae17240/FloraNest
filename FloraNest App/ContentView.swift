import SwiftUI
import UIKit

// Camera View
struct CameraView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedImage: UIImage?

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera
        picker.allowsEditing = false
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

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
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

import AVFoundation

func checkCameraAccess(completion: @escaping (Bool) -> Void) {
    let status = AVCaptureDevice.authorizationStatus(for: .video)
    switch status {
    case .authorized:
        completion(true)
    case .notDetermined:
        AVCaptureDevice.requestAccess(for: .video) { granted in
            completion(granted)
        }
    case .denied, .restricted:
        completion(false)
    @unknown default:
        completion(false)
    }
}



struct ContentView: View {
    @State private var isShowingCamera = false
    @State private var scannedImage: UIImage?

    var body: some View {
        ZStack {
            // Background Image
            Image("FNbackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            // Logo and Button
            VStack {
                Spacer()
                Text("FloraNest.")
                    .font(Font.custom("Fraunces", size: 50))
                    .foregroundColor(.white)
                Spacer()

                // Plant Button
                Button(action: {
                    checkCameraAccess { granted in
                        if granted {
                            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                                isShowingCamera = true
                            } else {
                                print("Camera not available")
                            }
                        } else {
                            print("Camera access denied. Please enable it in settings.")
                        }
                    }
                }) {
                    Text("Scan a plant")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(60)
                        .accessibilityLabel("Scan a plant button")
                }
                .padding(.bottom, 30)
                .sheet(isPresented: $isShowingCamera) {
                    CameraView(selectedImage: $scannedImage)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 15")
    }
}

