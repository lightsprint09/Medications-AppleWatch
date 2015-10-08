//
//  ExecutionTime+CoreDataProperties.swift
//  Medications
//
//  Created by Lukas Schmidt on 07.10.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension ExecutionTime {

    @NSManaged var amount: NSDecimalNumber?
    @NSManaged var assignmentDate: NSDate
    @NSManaged var assignmentTimeOfDay: NSNumber
    @NSManaged var creationDate: NSDate
    @NSManaged var executionDate: NSDate?
    @NSManaged var secondsMoved: NSNumber?
    @NSManaged var notExecuted: NSNumber
    @NSManaged var parentExecutionTime: RootExecutionTime

}
