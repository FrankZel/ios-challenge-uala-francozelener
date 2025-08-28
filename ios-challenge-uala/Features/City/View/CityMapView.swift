//
//  CityMapView.swift
//  ios-challenge-uala
//
//  Created by Franco Zelener on 27/08/2025.
//

import SwiftUI
import MapKit

struct CityMapView: View {
    
    var city: City
    @State var weatherViewModel = WeatherViewModel()
    
    @State private var mapPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: -58, longitude: -34),
            span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        )
    )
    
    var body: some View {
        ZStack {
            
            Map(position: $mapPosition) {
            }
            .onAppear {
                mapPosition = getPosition()
            }
            .task {
                try? await weatherViewModel.fetchWeather(city: city)
            }
            .safeAreaInset(edge:.top, alignment: .trailing, content: {
                WeatherViewOnMap(cityWeather: weatherViewModel.weather, viewModel: weatherViewModel)
                    .padding()
                }
            )
        }
    }
}

#Preview {
    CityMapView(city: City(country: "AR", name: "Ciudad Autónoma de Buenos Aires", id: 1, coord: Coordinate(lon: -34.606633, lat: -58.435344)))
}

extension CityMapView {
    
    
    func getPosition() -> MapCameraPosition {
        
        let lat = Double(city.coord.lat)
        let long = Double(city.coord.lon)
        
        return MapCameraPosition.region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude:lat ?? 0, longitude:long ?? 0 ),
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
        )
    }
}
