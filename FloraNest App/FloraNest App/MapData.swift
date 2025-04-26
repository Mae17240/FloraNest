import SwiftUI
import MapKit
import CoreLocation


struct LocalPlant: Decodable {
    let id: Int
    let common_name: String?
    let scientific_name: String
    let latitude: Double
    let longitude: Double
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 50.3755, longitude: -4.1427),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05) // Plymouth co ordinates for testing
    )
    @Published var localPlantLocations: [CLLocationCoordinate2D] = []

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        DispatchQueue.main.async {
            self.region = MKCoordinateRegion(
                center: location.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
        }
    }

}


struct MapKitView: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    var localPlantLocations: [CLLocationCoordinate2D]

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.setRegion(region, animated: true)
        addAnnotations(to: mapView)
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.setRegion(region, animated: true)
        addAnnotations(to: uiView)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    private func addAnnotations(to mapView: MKMapView) {
        mapView.removeAnnotations(mapView.annotations)
        for location in localPlantLocations {
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = "Local Plant"
            mapView.addAnnotation(annotation)
        }
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapKitView

        init(_ parent: MapKitView) {
            self.parent = parent
        }
    }
}


struct MapData: View {
    @StateObject private var locationManager = LocationManager()

    var body: some View {
        NavigationView {
            ZStack {
                Image("MainHome")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                VStack {
                    Text("Map Data.")
                        .font(Font.custom("Fraunces", size: 40))
                        .foregroundColor(.white)
                        .fontWeight(.semibold)

                    Text("View local plant-map data based in your area")
                        .font(Font.custom("Poppins-regular", size: 15))
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .padding(.bottom, 30)

                    MapKitView(region: $locationManager.region, localPlantLocations: locationManager.localPlantLocations)
                        .frame(width: 350, height: 430)
                        .cornerRadius(10)
                        .padding(.bottom, 50)

                    NavigationLink(destination: ContentView().navigationBarBackButtonHidden(true)) {
                        Text("home")
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(60)
                            .frame(maxWidth: 200)
                    }
                }
                .padding()
            }
        }
    }
}

struct MapData_Previews: PreviewProvider {
    static var previews: some View {
        MapData()
            .previewDevice("iPhone 15")
    }
}
