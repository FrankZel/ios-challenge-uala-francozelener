//
//  CityViewModel.swift
//  ios-challenge-uala
//
//  Created by Franco Zelener on 27/08/2025.
//

import Foundation

import Foundation

@Observable
class CityViewModel {
    
    @MainActor
    init() {
        Task {
            try? await fetchCities()
            favourites = UserDefaultsManager.loadFavourites()
        }
    }
    
    let url = "https://gist.githubusercontent.com/hernan-uala/dce8843a8edbe0b0018b32e137bc2b3a/raw/0996accf70cb0ca0e16f9a99e0ee185fafca7af1/cities.json"
    
    var cities: [City] = []
    var favourites: Set<Int> = []
    var showOnlyFavourites: Bool = false
    var isloading: Bool = true
    var searchText: String = ""
    
    func fetchCities() async throws {
        isloading = true
        guard let downloadedCities: [City] = await APIservice().downloadData(fromURL: url) else {return}
        self.cities = downloadedCities.sorted{ $0.name < $1.name }
        isloading = false
    }
    
    var favouriteCities: [City] {
        showOnlyFavourites ? cities.filter{isFavourite($0)} : cities
    }
    
    func toggleCityFavouriteTag(_ city: City) {
        if favourites.contains(city.id) {
            favourites.remove(city.id)
            UserDefaultsManager.removeFavouriteCity(id: city.id)
        } else {
            favourites.insert(city.id)
            UserDefaultsManager.addFavouriteCity(id: city.id)
        }
    }
    
    func isFavourite(_ city: City) -> Bool {
        return favourites.contains(city.id)
    }
    
    var filteredCities: [City] {
        if searchText.isEmpty {
            return showOnlyFavourites ? favouriteCities : cities
        } else {
            let baseList = showOnlyFavourites ? favouriteCities : cities
            return baseList.filter { $0.name.lowercased().hasPrefix(searchText.lowercased()) }
        }
    }
}
