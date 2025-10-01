//
//  WeatherService.swift
//  TravelJournal
//
//  Created by Purve Mahesh Patel on 10/1/25.
//

import Foundation

final class WeatherService {
    private let apiKey = "474311fcb151dd10975fa29515fb2d0a" // Replace with your key
    private let cacheDuration: TimeInterval = 10 * 60
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    // MARK: - Current Weather
    func fetchWeather(lat: Double, lon: Double, forceRefresh: Bool = false) async throws -> WeatherResponse {
        let cacheKey = cacheKeyFor(lat: lat, lon: lon)
        if !forceRefresh, let cached = getCachedWeather(forKey: cacheKey) {
            let age = Date().timeIntervalSince(cached.fetchedAt)
            if age <= cacheDuration { return cached.response }
        }
        
        guard var url = URLComponents(string: "https://api.openweathermap.org/data/2.5/weather") else {
            throw URLError(.badURL)
        }
        url.queryItems = [
            URLQueryItem(name: "lat", value: "\(lat)"),
            URLQueryItem(name: "lon", value: "\(lon)"),
            URLQueryItem(name: "appid", value: apiKey),
            URLQueryItem(name: "units", value: "metric")
        ]
        
        let (data, response) = try await session.data(from: url.url!)
        guard let http = response as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
            throw URLError(.badServerResponse)
        }
        let decoded = try JSONDecoder().decode(WeatherResponse.self, from: data)
        cacheWeather(decoded, forKey: cacheKey)
        return decoded
    }
    
    // MARK: - Forecast
    func fetchForecast(lat: Double, lon: Double) async throws -> [DailyForecast] {
        guard var url = URLComponents(string: "https://api.openweathermap.org/data/2.5/forecast") else {
            throw URLError(.badURL)
        }
        url.queryItems = [
            URLQueryItem(name: "lat", value: "\(lat)"),
            URLQueryItem(name: "lon", value: "\(lon)"),
            URLQueryItem(name: "appid", value: apiKey),
            URLQueryItem(name: "units", value: "metric")
        ]
        
        let (data, response) = try await session.data(from: url.url!)
        guard let http = response as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        let decoded = try JSONDecoder().decode(ForecastResponse.self, from: data)
        
        let grouped = Dictionary(grouping: decoded.list) { entry in
            let date = Date(timeIntervalSince1970: TimeInterval(entry.dt))
            return Calendar.current.startOfDay(for: date)
        }
        
        let dailySummaries = grouped.keys.sorted().prefix(3).map { day -> DailyForecast in
            let entries = grouped[day] ?? []
            let avgTemp = entries.map { $0.main.temp }.reduce(0, +) / Double(max(entries.count, 1))
            let mainDesc = entries.first?.weather.first?.description ?? "N/A"
            let icon = entries.first?.weather.first?.icon ?? "01d"
            return DailyForecast(date: day, avgTemp: avgTemp, description: mainDesc.capitalized, icon: icon)
        }
        
        return Array(dailySummaries)
    }
    
    // MARK: - Caching
    private func cacheKeyFor(lat: Double, lon: Double) -> String {
        "\(String(format: "%.4f", lat))_\(String(format: "%.4f", lon))"
    }
    
    private func cacheWeather(_ weather: WeatherResponse, forKey key: String) {
        let cached = CachedWeather(fetchedAt: Date(), response: weather)
        if let data = try? JSONEncoder().encode(cached) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    
    private func getCachedWeather(forKey key: String) -> CachedWeather? {
        guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
        return try? JSONDecoder().decode(CachedWeather.self, from: data)
    }
}
