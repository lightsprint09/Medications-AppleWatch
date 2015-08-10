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

    @NSManaged var activeSubstance: String?
    @NSManaged var color: NSObject?
    @NSManaged var companyName: String?
    @NSManaged var creationDate: NSDate?
    @NSManaged var doseOfSubstance: String?
    @NSManaged var userImage: NSData?
    @NSManaged var name: String?
    @NSManaged var abstractImage: NSData?
    @NSManaged var medications: NSSet?

}
