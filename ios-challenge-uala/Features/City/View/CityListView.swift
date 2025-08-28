//
//  CityListView.swift
//  ios-challenge-uala
//
//  Created by Franco Zelener on 27/08/2025.
//

import SwiftUI

struct CityListView: View {
    
    //    @State private var visibility: NavigationSplitViewVisibility = .doubleColumn
    @Environment(\.horizontalSizeClass) var hSize
    @State private var model = CityViewModel()
    @State private var selectedCity: City?
    
    var body: some View {
        //        if UIDevice.current.userInterfaceIdiom == .pad {
        //            NavigationSplitView(columnVisibility: $visibility) {
        //                List(selection: $selectedCity) {
        //                    if model.isloading {
        //                        ForEach(0..<10) { _ in
        //                            Text("Loading...")
        //                                .redacted(reason: .placeholder)
        //                        }
        //                    } else {
        //                        ForEach(model.filteredCities) { city in
        //                            CityCellView(city: city, viewModel: model)
        //                        }
        //                    }
        //                }
        //                .navigationTitle("Cities")
        //                .navigationBarItems(trailing:
        //                                        Toggle(isOn: $model.showOnlyFavourites) {
        //                    Text("Show favourites")
        //                }
        //                    .toggleStyle(.button)
        //                )
        //            } detail: {
        //                if let selectedCity{
        //                    CityMapView(city: selectedCity)
        //                }
        //            }
        //            .navigationSplitViewStyle(.balanced)
        //            .searchable(text: $model.searchText)
        //        }
        //        else {
        GeometryReader { geometry in
            let isLandscape = geometry.size.width > geometry.size.height // Using GeometryReader to detect landscape mode despite the device
            NavigationStack{
                Group {
                    if isLandscape {      // Landscape mode.
                        HStack {
                            ScrollView {
                                LazyVStack {
                                    if model.isloading {
                                        ForEach(0..<10) { _ in
                                            Text("Loading...")
                                            .redacted(reason: .placeholder)}
                                    } else {
                                        ForEach(model.filteredCities) { city in
                                            Button {
                                                selectedCity = city
                                            } label: {
                                                CityCellView(city: city, viewModel: model)
                                            }
                                        }
                                    }
                                }
                            }
                            .frame(maxWidth: geometry.size.width / 2)
                            .listStyle(.plain)
                            
                            Spacer()
                            
                            if let selected = selectedCity {
                                CityMapView(city: selected)
                                    .frame(maxWidth: .infinity)
                            } else {
                                Text("Select city")
                                Spacer()
                            }
                        }
                    } else {
                        ScrollView {
                            LazyVStack {
                                if model.isloading {
                                    ForEach(0..<10) { _ in
                                        Text("Loading...")
                                            .redacted(reason: .placeholder)
                                    }
                                } else {
                                    ForEach(model.filteredCities) { city in
                                        NavigationLink(value: city) {
                                            CityCellView(city: city, viewModel: model)
                                        }
                                    }
                                }
                            }
                            .padding()
                        }
                        
                        .navigationDestination(for: City.self) { city in
                            CityMapView(city: city)
                        }
                    }
                }
                
                .searchable(text: $model.searchText)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        HStack {
                            Text("Cities")
                                .font(.largeTitle)
                            Spacer()
                        }
                    }
                    ToolbarItem(placement: .automatic) {
                        Toggle(isOn: $model.showOnlyFavourites) {
                            Text("Show favourites")
                        }
                        .toggleStyle(.button)
                    }
                }    }
            
        }
    }
}
//}

#Preview {
    CityListView()
}
