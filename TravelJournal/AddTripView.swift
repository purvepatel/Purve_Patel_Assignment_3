//
//  AddTripView.swift
//  TravelJournal
//
//  Created by Purve Mahesh Patel on 10/1/25.
//

import SwiftUI

struct AddTripView: View {
    @Environment(\.presentationMode) var presentation
    @State private var name = ""
    @State private var latitude = ""
    @State private var longitude = ""
    @State private var notes = ""
    
    var onSave: (Trip) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Trip Info")) {
                    TextField("Name", text: $name)
                    TextField("Latitude", text: $latitude).keyboardType(.decimalPad)
                    TextField("Longitude", text: $longitude).keyboardType(.decimalPad)
                    TextField("Notes", text: $notes)
                }
            }
            .navigationTitle("Add Trip")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { presentation.wrappedValue.dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") { saveTrip() }.disabled(!canSave)
                }
            }
        }
    }
    
    private var canSave: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty &&
        Double(latitude) != nil && Double(longitude) != nil
    }
    
    private func saveTrip() {
        guard let lat = Double(latitude), let lon = Double(longitude) else { return }
        let newTrip = Trip(name: name, latitude: lat, longitude: lon, notes: notes)
        onSave(newTrip)
        presentation.wrappedValue.dismiss()
    }
}
