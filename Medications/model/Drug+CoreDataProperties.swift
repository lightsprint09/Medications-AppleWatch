//
//  Drug+CoreDataProperties.swift
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

extension Drug {

    @NSManaged var name: String?
    @NSManaged var activeSubstance: String?
    @NSManaged var doseOfSubstance: String?
    @NSManaged var companyName: String?
    @NSManaged var dateAdded: NSDate?
    @NSManaged var image: NSData?
    @NSManaged var color: NSObject?
    @NSManaged var medications: NSSet?

}
