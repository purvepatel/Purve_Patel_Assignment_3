//
//  Registrant+CoreDataProperties.swift
//  EventHub
//
//  Created by Purve Mahesh Patel on 10/3/25.
//

import Foundation
import CoreData

extension Registrant {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Registrant> {
        return NSFetchRequest<Registrant>(entityName: "Registrant")
    }

    @NSManaged public var id: UUID
    @NSManaged public var fullName: String
    @NSManaged public var email: String
    @NSManaged public var age: Int16
    @NSManaged public var gender: String
    @NSManaged public var isStudent: Bool
    @NSManaged public var createdAt: Date?
}

extension Registrant: Identifiable { }
