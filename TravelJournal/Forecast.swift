//
//  Forecast.swift
//  TravelJournal
//
//  Created by Purve Mahesh Patel on 10/1/25.
//

import Foundation

struct ForecastResponse: Codable {
    let list: [ForecastEntry]
}

struct ForecastEntry: Codable {
    let dt: Int
    let main: Main
    let weather: [Weather]
}

struct DailyForecast: Identifiable {
    let id = UUID()
    let date: Date
    let avgTemp: Double
    let description: String
    let icon: String
}
