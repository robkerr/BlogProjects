//
//  Weather.swift
//  ConcurrentDispatchQueue
//
//  Created by Rob Kerr on 1/20/21.
//

import Foundation

struct Weather : Decodable {
    let name: String
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Double
    let humidity: Double
    let visibility: Double
    let windSpeed: Double
    let windDirection: Double
}
