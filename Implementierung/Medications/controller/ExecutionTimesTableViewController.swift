//
//  MedicationTableViewController.swift
//  Medications
//
//  Created by Lukas Schmidt on 17.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import UIKit
import CoreData

class ExecutionTimesTableViewController: UITableViewController, ManagedObjectContextSettable {
    var managedObjectContext: NSManagedObjectContext!
    
    let executionTimeService = ExecutionTimeService()
    
    var dataSource: FetchedResultsDataSource<ExecutionTimesTableViewController>?
    
    override func viewDidLoad() {
        let fetchRequest = executionTimeService.allChildrenExecutionTimesFetchRequest()
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: "assignmentTimeOfDay", cacheName: nil)
        dataSource = FetchedResultsDataSource(tableView: tableView, fetchedResultsController: frc, delegate: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let managedObjectContextSettable = segue.destinationViewController as? ManagedObjectContextSettable {
           var managedObjectContextSettable = managedObjectContextSettable
            managedObjectContextSettable.managedObjectContext = managedObjectContext
        }
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = MedicationHeaderView(frame: CGRect(x: 0, y: 0, width: 300, height: 32))
        let timeOfDay = dataSource?.objectAtIndexPath(NSIndexPath(forRow: 0, inSection: section)).timeOfDay
        view.configureWithTimeOfDay(timeOfDay!)
        view.backgroundColor = UIColor(red:240 / 255.0, green:240 / 255.0, blue:240 / 255.0, alpha:1.0)
        return view
    }
}
