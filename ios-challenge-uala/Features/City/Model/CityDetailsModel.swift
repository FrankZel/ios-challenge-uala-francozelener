//
//  CityDetailsModel.swift
//  ios-challenge-uala
//
//  Created by Franco Zelener on 28/08/2025.
//

import Foundation

struct CityDetailsModel: Codable {
    let links: [Link]?
    let data: [CityDetail]?
    let metadata: Metadata?
}

struct Link: Codable {
    let rel: String?
    let href: String?
}

struct CityDetail: Codable, Identifiable {
    let id: Int?
    let wikiDataId: String?
    let type: String?
    let city: String?
    let name: String?
    let country: String?
    let countryCode: String?
    let region: String?
    let regionCode: String?
    let regionWdId: String?
    let latitude: Double?
    let longitude: Double?
    let population: Int?
    let distance: Double?
}

struct Metadata: Codable {
    let currentOffset: Int?
    let totalCount: Int?
}
