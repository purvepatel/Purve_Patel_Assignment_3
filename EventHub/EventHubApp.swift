//
//  EventHubApp.swift
//  EventHub
//
//  Created by Purve Mahesh Patel on 10/3/25.
//

import SwiftUI
import CoreData  

@main
struct EventHubApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
