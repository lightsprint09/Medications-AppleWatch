//
//  DrugTableViewController.swift
//  Medications
//
//  Created by Lukas Schmidt on 10.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import UIKit
import CoreData

class DrugTableViewController: UITableViewController, ManagedObjectContextSettable {
    var managedObjectContext: NSManagedObjectContext!
    var dataSource: FetchedResultsDataSource<DrugTableViewController>?
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        managedObjectContext.performChanges{
            let drug:Drug = self.managedObjectContext.insertObject()
            drug.name = "Lukas"
            drug.creationDate = NSDate()
        }
        let drug:Drug = managedObjectContext.createPersistentObject{d in
            d.name = "Aspirin"
            d.creationDate = NSDate()
        }
//        let drug2:Drug = managedObjectContext.createPersistentObject{d in
//            d.name = "Aspirin"
//        }
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        dataSource = FetchedResultsDataSource(tableView: tableView, fetchedResultsController: frc, delegate: self)
    }
    
    func fetchRequest() -> NSFetchRequest {
        return Drug.sortedFetchRequest
    }
}
