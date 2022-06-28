//
//  MapView.swift
//  HowtaiBus
//
//  Created by Ting on 2022/6/27.
//

import SwiftUI
import MapKit

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

struct MapView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    //@State private var region = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 40.83834587046632, longitude: 14.254053016537693),
//        span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
//    )
    
    private let places = [
        //2.
        Location(name: "Galeria Umberto I", latitude: 40.83859036140747, longitude:  14.24945566830365),
        Location(name: "Castel dell'Ovo", latitude: 40.828206, longitude: 14.247549),
        Location(name: "Piazza Dante", latitude: 40.848891382971985, longitude: 14.250055428532933),
        Location(name: "Piazza Dante", latitude: 40.848891382971985, longitude: 14.250055428532933)
        
    ]
    
    var body: some View {
        
//        Map(coordinateRegion: $region, annotationItems: places) { place in
//                    MapAnnotation(coordinate: place.coordinate) {
//                        Image(systemName: "mappin.circle.fill")
//                            .font(.title)
//                            .foregroundColor(.blue)
//                    }
//                }
        
//        Map(coordinateRegion: $region, annotationItems: places) { place in
//            MapPin(coordinate: place.coordinate)
//        }
        Map(coordinateRegion: $viewModel.region, annotationItems: places) { place in
                    MapMarker(coordinate: place.coordinate)
                }
//        Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
//            .onAppear {
//                viewModel.checkLocationAuth()
//            }
        .edgesIgnoringSafeArea(.all)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

class ContentViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    var locationManger: CLLocationManager?
    
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.83834587046632, longitude: 14.254053016537693),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    func ckeckIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManger = CLLocationManager()
            locationManger?.delegate = self
            //checkLocationAuth()
            //locationManger?.activityType = .airborne
            locationManger?.desiredAccuracy = kCLLocationAccuracyBest
        } else {
            print("Show an alert leetin")
        }
    }
    
    func checkLocationAuth() {
        guard let locationManger = locationManger else {
            return
        }
        
        switch locationManger.authorizationStatus {
            
        case .notDetermined:
            locationManger.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location is restricted likely due to parental controls.")
        case .denied:
            print("Your have denied this app location permission. Go into settings to change it")
        case .authorizedAlways , .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManger.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        @unknown default:
            break
        }

    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuth()
    }
}
