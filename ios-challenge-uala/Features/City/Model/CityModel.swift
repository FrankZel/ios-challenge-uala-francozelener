//
//  CityModel.swift
//  ios-challenge-uala
//
//  Created by Franco Zelener on 27/08/2025.
//

import Foundation

import Foundation

struct City: Codable, Identifiable, Hashable {
    var country, name: String
    var id: Int
    var coord: Coordinate
    var isFavourite: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case country
        case name
        case id = "_id"
        case coord
    }
}

struct Coordinate: Codable, Hashable {
    var lon, lat: Double
}
