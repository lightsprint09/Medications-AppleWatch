//
//  ExecutionTime+CoreDataProperties.swift
//  Medications
//
//  Created by Lukas Schmidt on 10.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//
//  Delete this file and regenerate it using "Create NSManagedObject Subclass…"
//  to keep your implementation up to date with your model.
//

import Foundation
import CoreData

extension ExecutionTime {

    @NSManaged var assignmentDate: NSDate?
    @NSManaged var creationDate: NSDate?
    @NSManaged var executionDate: NSDate?
    @NSManaged var millisecondsMoved: NSNumber?
    @NSManaged var medications: NSSet?

}
