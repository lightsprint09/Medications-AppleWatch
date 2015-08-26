//
//  MedicationTableViewController.swift
//  Medications
//
//  Created by Lukas Schmidt on 17.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import UIKit
import CoreData

class MedicationTableViewController: UITableViewController, ManagedObjectContextSettable {
    var managedObjectContext: NSManagedObjectContext!
    
    var dataSource: FetchedResultsDataSource<MedicationTableViewController>?
    
    override func viewDidLoad() {
        let frc = NSFetchedResultsController(fetchRequest: executionFetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: "assignmentTimeOfDay", cacheName: nil)
        dataSource = FetchedResultsDataSource(tableView: tableView, fetchedResultsController: frc, delegate: self)
    }
    
    func executionFetchRequest() -> NSFetchRequest {
        let request = NSFetchRequest(entityName: ExecutionTime.entityName)
        request.sortDescriptors = [NSSortDescriptor(key: "assignmentDate", ascending: true)]
        
        return request
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let managedObjectContextSettable = segue.destinationViewController as? ManagedObjectContextSettable {
           var managedObjectContextSettable = managedObjectContextSettable
            managedObjectContextSettable.managedObjectContext = managedObjectContext
        }
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 34))
        let timeOfDay = dataSource?.objectAtIndexPath(NSIndexPath(forRow: 0, inSection: section)).timeOfDay
        label.text = timeOfDay?.toString
        return label
    }
}
