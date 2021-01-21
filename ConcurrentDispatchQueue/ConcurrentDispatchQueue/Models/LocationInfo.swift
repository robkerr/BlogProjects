//
//  LocationInfo.swift
//  ConcurrentDispatchQueue
//
//  Created by Rob Kerr on 1/20/21.
//

import Foundation

struct LocationInfo : Decodable {
    let lon: Double
    let lat: Double
    let foundedYear: Int
    let population: Int
    let areaCode: String
    let imageUrl: String
    var weather: Weather?
    
    mutating func setWeather(weather: Weather) {
        self.weather = weather
    }
}
