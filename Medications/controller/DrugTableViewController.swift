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
    let drugService = DrugDBService()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        let frc = NSFetchedResultsController(fetchRequest: drugService.sortedFetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        dataSource = FetchedResultsDataSource(tableView: tableView, fetchedResultsController: frc, delegate: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let drugSettabel = segue.destinationViewController as? DrugSettable, dataSource = dataSource, indexPath = tableView.indexPathForSelectedRow  {
            var drugSettabel = drugSettabel
            drugSettabel.drug = dataSource.objectAtIndexPath(indexPath)
        }
        guard let addDrugVC = segue.destinationViewController as? ManagedObjectContextSettable else {return}
        var vc = addDrugVC
        vc.managedObjectContext = managedObjectContext
    }

    
    
}
