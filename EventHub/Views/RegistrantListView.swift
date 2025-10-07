//
//  RegistrantListView.swift
//  EventHub
//
//  Created by Purve Mahesh Patel on 10/3/25.
//

import SwiftUI
import CoreData

struct RegistrantListView: View {
    @Environment(\.managedObjectContext) private var context

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Registrant.createdAt, ascending: false)],
        animation: .default
    ) private var registrants: FetchedResults<Registrant>

    var body: some View {
        List {
            if registrants.isEmpty {
                Text("No registrants yet.")
                    .foregroundColor(.secondary)
            } else {
                ForEach(registrants) { r in
                    VStack(alignment: .leading) {
                        Text(r.fullName).font(.headline)
                        Text(r.email).font(.subheadline)
                        HStack {
                            Text("Age: \(r.age)")
                            Spacer()
                            Text(r.isStudent ? "Student" : "Non-student")
                            Spacer()
                            if let date = r.createdAt {
                                Text(date, style: .date)
                            }
                        }
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    }
                }
                .onDelete(perform: delete)
            }
        }
        .navigationTitle("All Registrants")
        .toolbar { EditButton() }
    }

    private func delete(at offsets: IndexSet) {
        withAnimation {
            offsets.map { registrants[$0] }.forEach(context.delete)
            do {
                try context.save()
            } catch {
                print("Delete error: \(error.localizedDescription)")
            }
        }
    }
}
