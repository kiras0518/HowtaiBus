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
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.83834587046632, longitude: 14.254053016537693),
        span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
    )
    
    private let places = [
        //2.
        Location(name: "Galeria Umberto I", latitude: 40.83859036140747, longitude:  14.24945566830365),
        Location(name: "Castel dell'Ovo", latitude: 40.828206, longitude: 14.247549),
        Location(name: "Piazza Dante", latitude: 40.848891382971985, longitude: 14.250055428532933),
        Location(name: "Piazza Dante", latitude: 40.848891382971985, longitude: 14.250055428532933)
        
    ]
    
    var body: some View {
        
        Map(coordinateRegion: $region, annotationItems: places) { place in
                    MapAnnotation(coordinate: place.coordinate) {
                        Image(systemName: "mappin.circle.fill")
                            .font(.title)
                            .foregroundColor(.blue)
                    }
                }
        
//        Map(coordinateRegion: $region, annotationItems: places) { place in
//            MapPin(coordinate: place.coordinate)
//        }
        //        Map(coordinateRegion: $region, annotationItems: places) { place in
        //            MapMarker(coordinate: place.coordinate)
        //        }
        //Map(coordinateRegion: $region)
        .edgesIgnoringSafeArea(.all)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
