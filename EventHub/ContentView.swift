//
//  ContentView.swift
//  EventHub
//
//  Created by Purve Mahesh Patel on 10/3/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationStack {
                RegistrationView()
            }
            .tabItem {
                Label("Register", systemImage: "pencil")
            }

            NavigationStack {
                RegistrantListView()
            }
            .tabItem {
                Label("Registrants", systemImage: "list.bullet")
            }
        }
    }
}
