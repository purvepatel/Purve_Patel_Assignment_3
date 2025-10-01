//
//  Weather.swift
//  TravelJournal
//
//  Created by Purve Mahesh Patel on 10/1/25.
//

import Foundation

struct WeatherResponse: Codable {
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
    let humidity: Int
}

struct Weather: Codable {
    let description: String
    let icon: String
}

// Cached wrapper
struct CachedWeather: Codable {
    let fetchedAt: Date
    let response: WeatherResponse
}
