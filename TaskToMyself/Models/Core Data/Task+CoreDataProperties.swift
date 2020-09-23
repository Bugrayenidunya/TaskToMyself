//
//  Task+CoreDataProperties.swift
//  
//
//  Created by Bugra's Mac on 12.09.2020.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var body: String?
    @NSManaged public var isDone: Bool
    @NSManaged public var dueDate: Date?

}
