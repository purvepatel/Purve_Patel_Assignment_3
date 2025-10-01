//
//  TripListView.swift
//  TravelJournal
//
//  Created by Purve Mahesh Patel on 10/1/25.
//

import SwiftUI

struct TripListView: View {
    @State private var trips: [Trip] = [
        Trip(name: "Toronto", latitude: 43.65107, longitude: -79.347015),
        Trip(name: "Vancouver", latitude: 49.2827, longitude: -123.1207),
        Trip(name: "Paris", latitude: 48.8566, longitude: 2.3522)
    ]
    
    @State private var showingAdd = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(trips) { trip in
                    NavigationLink(destination: TripDetailView(trip: trip)) {
                        VStack(alignment: .leading) {
                            Text(trip.name).font(.headline)
                            Text("\(trip.latitude), \(trip.longitude)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .onDelete(perform: delete)
            }
            .navigationTitle("My Trips")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAdd = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .bottomBar) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAdd) {
                AddTripView { newTrip in
                    trips.append(newTrip)
                    showingAdd = false
                }
            }
        }
    }
    
    private func delete(at offsets: IndexSet) {
        trips.remove(atOffsets: offsets)
    }
}
