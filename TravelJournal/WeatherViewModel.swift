//
//  WeatherViewModel.swift
//  TravelJournal
//
//  Created by Purve Mahesh Patel on 10/1/25.
//

import Foundation
import Combine

@MainActor
final class WeatherViewModel: ObservableObject {
    @Published var weather: WeatherResponse?
    @Published var forecast: [DailyForecast] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let service = WeatherService()
    private var lastCoords: (Double, Double)?
    
    func loadWeather(lat: Double, lon: Double, forceRefresh: Bool = false) async {
        if !forceRefresh, let last = lastCoords, last.0 == lat, last.1 == lon, weather != nil { return }
        
        isLoading = true
        errorMessage = nil
        do {
            weather = try await service.fetchWeather(lat: lat, lon: lon, forceRefresh: forceRefresh)
            forecast = try await service.fetchForecast(lat: lat, lon: lon)
            lastCoords = (lat, lon)
        } catch {
            errorMessage = error.localizedDescription
            weather = nil
            forecast = []
        }
        isLoading = false
    }
    
    func weatherSummary() -> String? {
        guard let w = weather else { return nil }
        let temp = String(format: "%.1f°C", w.main.temp)
        let desc = w.weather.first?.description.capitalized ?? ""
        return "\(temp), \(desc)"
    }
}

