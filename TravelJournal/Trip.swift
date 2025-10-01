//
//  Trip.swift
//  TravelJournal
//
//  Created by Purve Mahesh Patel on 10/1/25.
//

import Foundation

struct Trip: Identifiable, Codable {
    let id: UUID
    var name: String
    var latitude: Double
    var longitude: Double
    var notes: String?
    
    init(id: UUID = UUID(), name: String, latitude: Double, longitude: Double, notes: String? = nil) {
        self.id = id
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.notes = notes
    }
}
