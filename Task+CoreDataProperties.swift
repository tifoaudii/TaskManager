//
//  Task+CoreDataProperties.swift
//  TaskManager
//
//  Created by Tifo Audi Alif Putra on 09/05/22.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var title: String?
    @NSManaged public var type: String?
    @NSManaged public var deadline: Date?
    @NSManaged public var color: NSObject?
    @NSManaged public var isCompleted: Bool

}

extension Task : Identifiable {

}
