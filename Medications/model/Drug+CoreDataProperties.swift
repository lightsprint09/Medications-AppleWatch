//
//  Drug+CoreDataProperties.swift
//  Medications
//
//  Created by Lukas Schmidt on 12.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//
//  Delete this file and regenerate it using "Create NSManagedObject Subclass…"
//  to keep your implementation up to date with your model.
//

import Foundation
import CoreData

extension Drug {

    @NSManaged var activeSubstance: String?
    @NSManaged var color: UIColor?
    @NSManaged var companyName: String?
    @NSManaged var creationDate: NSDate?
    @NSManaged var doseOfSubstance: String?
    @NSManaged var name: String?
    @NSManaged var userImage: NSData?
    @NSManaged var imageKind: NSNumber?
    @NSManaged var secondColor: UIColor?
    @NSManaged var medications: NSSet?

}
