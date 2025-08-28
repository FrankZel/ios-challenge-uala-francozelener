//
//  CityDetailsViewModel.swift
//  ios-challenge-uala
//
//  Created by Franco Zelener on 28/08/2025.
//

import Foundation

@Observable
class CityDetailsViewModel {
    
    
    let API_KEY = "b68bb78ef0msha8b1569b7e1bd18p1e7499jsn7a7adeba3415"
    let HOST = "wft-geo-db.p.rapidapi.com"
    
    var cityDetails: CityDetailsModel?
    
    
    func fetchCityDetails(city: City) async throws {
        let coords = buildCoords(city: city)
        
        let baseUrl = "https://wft-geo-db.p.rapidapi.com/v1/geo/cities?location=\(coords)"
        guard let details: CityDetailsModel = await APIservice().downloadData(fromURL: baseUrl, rapidApiKey: API_KEY, host: HOST) else {return}
        self.cityDetails = details
    }
    
    private func buildCoords(city: City) -> String{
        let lat = city.coord.lat.rounded(toPlaces: 4)
        let long = city.coord.lon.rounded(toPlaces: 4)
        
        let latPrefix = lat >= 0 ? "%2b" : ""
        let longPrefix = long >= 0 ? "%2b" : ""
        
        return "\(latPrefix)\(lat)\(longPrefix)\(long)"
    }
    
}


extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let multiplier = pow(10.0, Double(places))
        return (self * multiplier).rounded() / multiplier
    }
}
