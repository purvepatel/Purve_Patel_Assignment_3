//
//  RegistrationViewModel.swift
//  EventHub
//
//  Created by Purve Mahesh Patel on 10/3/25.
//

import Foundation
import CoreData
import SwiftUI
internal import Combine

final class RegistrationViewModel: ObservableObject {
    @Published var fullName = ""
    @Published var email = ""
    @Published var age = 18
    @Published var gender = "Prefer not to say"
    @Published var isStudent = false

    @Published var showAlert = false
    @Published var alertMessage = ""

    func validateAndSave(context: NSManagedObjectContext) -> Registrant? {
        // Validation
        if fullName.trimmingCharacters(in: .whitespaces).isEmpty {
            alertMessage = "Full name cannot be empty."
            showAlert = true
            return nil
        }

        if !email.contains("@") {
            alertMessage = "Email must contain @."
            showAlert = true
            return nil
        }

        if age < 18 {
            alertMessage = "Age must be at least 18."
            showAlert = true
            return nil
        }

        // Save record
        let newRegistrant = Registrant(context: context)
        newRegistrant.id = UUID()
        newRegistrant.fullName = fullName
        newRegistrant.email = email
        newRegistrant.age = Int16(age)
        newRegistrant.gender = gender
        newRegistrant.isStudent = isStudent
        newRegistrant.createdAt = Date()

        do {
            try context.save()
            print("""
            New registrant added:
            Name: \(fullName)
            Email: \(email)
            Age: \(age)
            Gender: \(gender)
            Student: \(isStudent ? "Yes" : "No")
            """)
            return newRegistrant
        } catch {
            alertMessage = "Failed to save: \(error.localizedDescription)"
            showAlert = true
            return nil
        }
    }

    func clear() {
        fullName = ""
        email = ""
        age = 18
        gender = "Prefer not to say"
        isStudent = false
    }
}
