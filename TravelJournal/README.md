Travel Journal App — Assignment 3 (API Integration & Live Data)

This SwiftUI Travel Journal demo integrates OpenWeatherMap to fetch and display live weather for each trip's latitude & longitude. It demonstrates networking with URLSession + async/await, JSON parsing via Codable, MVVM architecture, reactive UI updates, error handling, and caching.

Files included
- TravelJournalApp.swift
- ContentView.swift
- Trip.swift
- Weather.swift
- WeatherService.swift
- WeatherViewModel.swift
- TripListView.swift
- TripDetailView.swift
- AddTripView.swift
- Forecast.swift

All files are single-file units to be pasted into an Xcode project root (as requested).

How to run
1. Open Xcode and create a new SwiftUI App project or add these files to an existing project.
2. Set the Organization Identifier to `com.conestoga` in the project settings (see note below).
3. Replace the API key and build/run on simulator or device (iOS 15+ target recommended).

JSON parsing
- `WeatherResponse`, `Main`, and `Weather` conform to `Decodable`.
- Parsing is performed with `JSONDecoder`.

Networking
- Uses `URLSession` with `async/await` (iOS 15+).
- Handles HTTP response status checking and throws on error.
s
UI/UX
- SwiftUI views with `@StateObject` and `@Published` for reactive updates.
- `AsyncImage` used for weather icons (fallback to system icon on fail).
- Loading and error states are displayed.

Cached weather in UserDefaults (avoids duplicate API calls).
3-day forecast (reduced from OpenWeather 5-day/3-hour data).
Retry button on error.
Animated icons not implemented to avoid adding dependencies
