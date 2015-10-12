//
//  Drug+CoreDataProperties.swift
//  Medications
//
//  Created by Lukas Schmidt on 07.10.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import UIKit
import CoreData

extension Drug {

    @NSManaged var activeSubstance: String?
    @NSManaged var color: UIColor?
    @NSManaged var companyName: String?
    @NSManaged var creationDate: NSDate?
    @NSManaged var doseOfSubstance: String?
    @NSManaged var imageKind: NSNumber?
    @NSManaged var name: String
    @NSManaged var userImage: NSData?
    @NSManaged var pillImage: NSData?
    @NSManaged var executionTimes: NSSet

}
