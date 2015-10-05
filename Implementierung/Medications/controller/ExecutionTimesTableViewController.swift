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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard let executionTime = dataSource?.objectAtIndexPath(indexPath), let drug = executionTime.parentExecutionTime.drug  else { return }
        let actionViewcontroller = UIAlertController(title: "\n\n\n\n\n\n", message: "", preferredStyle: UIAlertControllerStyle.ActionSheet)
        if let _ = executionTime.executionDate {
            let revokeMedikationAction = UIAlertAction(title: "Nicht genommen", style: .Default) { (action) in
                executionTime.executionDate = nil
            }
            actionViewcontroller.addAction(revokeMedikationAction)
        } else {let takeMedikationAction = UIAlertAction(title: "Genommen", style: .Default) { (action) in
            executionTime.executionDate = NSDate()
            }
            let moveToLaterAction = UIAlertAction(title: "Später nehmen", style: .Destructive, handler: nil)
            actionViewcontroller.addAction(moveToLaterAction)
            actionViewcontroller.addAction(takeMedikationAction)
        }
        
        let cancle = UIAlertAction(title: "Abbrechen", style: .Cancel, handler: nil)
        
        actionViewcontroller.addAction(cancle)
        let detailView = ExecutionTimeDetailView(frame: actionViewcontroller.view.frame, drug: drug, executionTime: executionTime)
        actionViewcontroller.view.addSubview(detailView)
        
        self.presentViewController(actionViewcontroller, animated: true, completion: nil)
    }
    @IBAction func testPush(sender: AnyObject) {
        guard let executionTime = dataSource?.objectAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) else { return }
        let notification = executionTimeService.createNotification(executionTime.parentExecutionTime)
        notification.repeatInterval = .Year
        notification.fireDate = NSDate().dateByAddingTimeInterval(15)
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
}
