//
//  Persistence.swift
//  EventHub
//
//  Created by Purve Mahesh Patel on 10/3/25.
//

import Foundation
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        // Create Core Data model programmatically
        let model = NSManagedObjectModel()
        let entity = NSEntityDescription()
        entity.name = "Registrant"
        entity.managedObjectClassName = "Registrant"

        // Attributes
        var attributes: [NSAttributeDescription] = []

        let id = NSAttributeDescription()
        id.name = "id"
        id.attributeType = .UUIDAttributeType
        id.isOptional = false
        attributes.append(id)

        let name = NSAttributeDescription()
        name.name = "fullName"
        name.attributeType = .stringAttributeType
        name.isOptional = false
        attributes.append(name)

        let email = NSAttributeDescription()
        email.name = "email"
        email.attributeType = .stringAttributeType
        email.isOptional = false
        attributes.append(email)

        let age = NSAttributeDescription()
        age.name = "age"
        age.attributeType = .integer16AttributeType
        age.isOptional = false
        attributes.append(age)

        let gender = NSAttributeDescription()
        gender.name = "gender"
        gender.attributeType = .stringAttributeType
        gender.isOptional = false
        attributes.append(gender)

        let isStudent = NSAttributeDescription()
        isStudent.name = "isStudent"
        isStudent.attributeType = .booleanAttributeType
        isStudent.isOptional = false
        attributes.append(isStudent)

        let createdAt = NSAttributeDescription()
        createdAt.name = "createdAt"
        createdAt.attributeType = .dateAttributeType
        createdAt.isOptional = true
        attributes.append(createdAt)

        entity.properties = attributes
        model.entities = [entity]

        container = NSPersistentContainer(name: "EventHubModel", managedObjectModel: model)

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Core Data store failed: \(error.localizedDescription)")
            }
        }

        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
