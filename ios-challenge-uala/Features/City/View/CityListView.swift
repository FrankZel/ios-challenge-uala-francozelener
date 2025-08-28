//
//  CityListView.swift
//  ios-challenge-uala
//
//  Created by Franco Zelener on 27/08/2025.
//

import SwiftUI

struct CityListView: View {
    
    @State private var visibility: NavigationSplitViewVisibility = .doubleColumn
    @State private var model = CityViewModel()
    @State private var searchText = ""
    @State private var selectedCity: City?
    
    var body: some View {
        NavigationSplitView(columnVisibility: $visibility) {
            List(selection: $selectedCity) {
                ForEach(searchResults) { city in
                    CityCellView(city: city, viewModel: model)
                }
            }
            .navigationTitle("Cities")
            .task {
                try? await model.fetchCities()
            }
            .navigationBarItems(trailing:
                    Toggle(isOn: $model.showOnlyFavourites) {
                        Text("Show favourites")
                    }
                .toggleStyle(.button)
            )            
        } detail: {
            if let selectedCity{
                CityMapView(city: selectedCity)
            }
        }
        .navigationSplitViewStyle(.balanced)
        .searchable(text: $searchText)
            
    }
    
    var searchResults: [City] {
        if searchText.isEmpty {
            return model.favouriteCities
        } else {
            return model.favouriteCities.filter { $0.name.starts(with: searchText) }
        }
    }
}

#Preview {
    CityListView()
}
