//
//  RegistrationView.swift
//  EventHub
//
//  Created by Purve Mahesh Patel on 10/3/25.
//

import SwiftUI
import CoreData

struct RegistrationView: View {
    @Environment(\.managedObjectContext) private var context
    @StateObject private var vm = RegistrationViewModel()

    @State private var showConfirmation = false
    @State private var savedRegistrant: Registrant?

    private let genders = ["Male", "Female", "Non-binary", "Prefer not to say"]

    var body: some View {
        Form {
            Section("Personal Information") {
                TextField("Full Name", text: $vm.fullName)
                TextField("Email", text: $vm.email)
                    .keyboardType(.emailAddress)

                Stepper(value: $vm.age, in: 18...120) {
                    HStack {
                        Text("Age")
                        Spacer()
                        Text("\(vm.age)")
                    }
                }

                Picker("Gender", selection: $vm.gender) {
                    ForEach(genders, id: \.self) { Text($0) }
                }
            }

            Section {
                Toggle("Are you a student?", isOn: $vm.isStudent)
            }

            Section {
                Button("Submit Registration") {
                    submit()
                }
                .frame(maxWidth: .infinity)
            }
        }
        .navigationTitle("Event Registration")
        .alert(isPresented: $vm.showAlert) {
            Alert(title: Text("Validation Error"), message: Text(vm.alertMessage), dismissButton: .default(Text("OK")))
        }
        .background(
            NavigationLink(destination: ConfirmationView(registrant: savedRegistrant, onDismiss: vm.clear),
                           isActive: $showConfirmation) { EmptyView() }
            .hidden()
        )
    }

    private func submit() {
        if let result = vm.validateAndSave(context: context) {
            savedRegistrant = result
            showConfirmation = true
        }
    }
}
