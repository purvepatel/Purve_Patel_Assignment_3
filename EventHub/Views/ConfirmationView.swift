//
//  ConfirmationView.swift
//  EventHub
//
//  Created by Purve Mahesh Patel on 10/3/25.
//

import SwiftUI

struct ConfirmationView: View {
    var registrant: Registrant?
    var onDismiss: (() -> Void)?
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .foregroundColor(.green)

            Text("Thank You for Registering!")
                .font(.title2)
                .bold()

            if let r = registrant {
                VStack(alignment: .leading, spacing: 8) {
                    HStack { Text("Name:").bold(); Spacer(); Text(r.fullName) }
                    HStack { Text("Email:").bold(); Spacer(); Text(r.email) }
                    HStack { Text("Age:").bold(); Spacer(); Text("\(r.age)") }
                    HStack { Text("Gender:").bold(); Spacer(); Text(r.gender) }
                    HStack { Text("Student:").bold(); Spacer(); Text(r.isStudent ? "Yes" : "No") }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(.thinMaterial))
            }

            Spacer()

            Button("Register Another") {
                onDismiss?()
                dismiss()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .navigationBarBackButtonHidden(true)
    }
}
