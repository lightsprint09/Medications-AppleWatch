//
//  DaytimeMedicationViewController.swift
//  Medications
//
//  Created by Lukas Schmidt on 21.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import UIKit
import CoreData

class DaytimeMedicationViewController: UICollectionViewController, ManagedObjectContextSettable {
    let daytimeDataSource = DayTimeSource()
    
    override func viewDidLoad() {
        collectionView?.dataSource = daytimeDataSource
    }
    
    var managedObjectContext: NSManagedObjectContext!
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let managedObjectContextSettable = segue.destinationViewController as? ManagedObjectContextSettable {
            var managedObjectContextSettable = managedObjectContextSettable
            managedObjectContextSettable.managedObjectContext = managedObjectContext
        }
    }
}
