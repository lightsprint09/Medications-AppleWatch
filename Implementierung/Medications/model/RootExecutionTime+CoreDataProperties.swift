//
//  RootExecutionTime+CoreDataProperties.swift
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

extension RootExecutionTime {

    @NSManaged var amount: NSDecimalNumber?
    @NSManaged var assignmentTime: NSDate
    @NSManaged var drug: Drug?
    @NSManaged var executionTimes: NSSet

}
