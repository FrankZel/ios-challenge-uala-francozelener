//
//  UserDefaultsManager.swift
//  ios-challenge-uala
//
//  Created by Franco Zelener on 28/08/2025.
//

import Foundation

class UserDefaultsManager {
    
    enum UserDefaultsKeys: String {
        case favouriteCities = "FavouriteCities"
    }
    
    static func addFavouriteCity(id cityId: Int) {
        var favourites = loadFavourites()
        favourites.insert(cityId)
        UserDefaults.standard.set(Array(favourites), forKey: UserDefaultsKeys.favouriteCities.rawValue)
    }
    
    static func removeFavouriteCity(id cityId: Int) {
       var favourites = loadFavourites()
        favourites.remove(cityId)
        UserDefaults.standard.set(Array(favourites), forKey: UserDefaultsKeys.favouriteCities.rawValue)
    }
    
    static func loadFavourites() -> Set<Int> {
        if let saved = UserDefaults.standard.array(forKey: UserDefaultsKeys.favouriteCities.rawValue) as? [Int] {
            return Set(saved)
        } else {
            return []
        }
    }
}
