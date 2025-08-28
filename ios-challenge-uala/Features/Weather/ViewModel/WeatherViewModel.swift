//
//  WeatherViewModel.swift
//  ios-challenge-uala
//
//  Created by Franco Zelener on 28/08/2025.
//

import Foundation

@Observable
class WeatherViewModel {
    
    let API_KEY = "d4b50d42dbea8f8a23fd18dd32e63974"
    var weather: WeatherModel?
    
    
    func fetchWeather(city: City) async throws{
        let baseUrl = "https://api.openweathermap.org/data/2.5/weather?q=\(city.name)&appid=\(API_KEY)&units=metric"
        guard let weather: WeatherModel = await APIservice().downloadData(fromURL: baseUrl) else { return }
        self.weather = weather
    }
    
    func getIconUrl() -> URL? {
        guard let icon = weather?.weather?.first?.icon else { return nil }
        return URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png")
    }
}
