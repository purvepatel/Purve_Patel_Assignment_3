//
//  TripDetailView.swift
//  TravelJournal
//
//  Created by Purve Mahesh Patel on 10/1/25.
//

import SwiftUI

struct TripDetailView: View {
    let trip: Trip
    @StateObject private var weatherVM = WeatherViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(trip.name)
                    .font(.largeTitle)
                    .bold()
                
                Divider()
                
                if weatherVM.isLoading {
                    ProgressView("Loading weather…")
                } else if let weather = weatherVM.weather {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Weather")
                            .font(.headline)
                        Text("\(weather.main.temp, specifier: "%.1f")°C")
                            .font(.title2)
                        Text(weather.weather.first?.description.capitalized ?? "")
                        Text("Humidity: \(weather.main.humidity)%")
                        
                        if let icon = weather.weather.first?.icon {
                            AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png")) { image in
                                image.resizable()
                            } placeholder: { ProgressView() }
                                .frame(width: 50, height: 50)
                        }
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 12).fill(Color(.secondarySystemBackground)))
                } else if let error = weatherVM.errorMessage {
                    Text(error).foregroundColor(.red)
                    Button("Retry") {
                        Task { await weatherVM.loadWeather(lat: trip.latitude, lon: trip.longitude, forceRefresh: true) }
                    }
                }
                
                // Forecast
                if !weatherVM.forecast.isEmpty {
                    Divider()
                    VStack(alignment: .leading, spacing: 8) {
                        Text("3-Day Forecast")
                            .font(.headline)
                        ForEach(weatherVM.forecast) { day in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(day.date, style: .date).font(.subheadline)
                                    Text("\(day.avgTemp, specifier: "%.1f")°C, \(day.description)").font(.caption)
                                }
                                Spacer()
                                AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(day.icon)@2x.png")) { img in
                                    img.resizable().scaledToFit()
                                } placeholder: { ProgressView() }
                                .frame(width: 40, height: 40)
                            }
                        }
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 12).fill(Color(.secondarySystemBackground)))
                }
            }
            .padding()
        }
        .task {
            await weatherVM.loadWeather(lat: trip.latitude, lon: trip.longitude)
        }
    }
}
