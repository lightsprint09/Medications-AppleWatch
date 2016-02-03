//
//  MedicationTableViewController.swift
//  Medications
//
//  Created by Lukas Schmidt on 17.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import UIKit
import CoreData
import CoreDataStack

extension ExecutionTimesTableViewController: DataProviderDelegate, DataSourceDelegate {
    typealias Object = ExecutionTime
    
    func dataProviderDidUpdate(updates: [DataProviderUpdate<Object>]?) {
        dataSource.processUpdates(updates)
    }
    
    func cellIdentifierForObject(object: Object) -> String {
        return "medication-cell"
    }
}

class ExecutionTimesTableViewController: UITableViewController, ManagedObjectContextSettable {
    var managedObjectContext: NSManagedObjectContext!
    
    let executionTimeService = ExecutionTimeService()
    var watchExecutionTimeService: WatchExecutionTimeService!
    var dataProvider:FetchedResultsDataProvider<ExecutionTimesTableViewController>!
    var dataSource: TableViewDataSource<ExecutionTimesTableViewController, FetchedResultsDataProvider<ExecutionTimesTableViewController>, MedicationTableCell>!
    
    override func viewDidLoad() {
        let fetchRequest = self.executionTimeService.allChildrenExecutionTimesFetchRequest(NSDate())
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: "assignmentTimeOfDay")
        dataProvider = FetchedResultsDataProvider(fetchedResultsController: frc, delegate: self)
        dataSource = TableViewDataSource<ExecutionTimesTableViewController, FetchedResultsDataProvider<ExecutionTimesTableViewController>, MedicationTableCell>(tableView: tableView, dataProvider: dataProvider, delegate: self)
        
        setupWatchConnection()
    }
    
    func setupWatchConnection() {
        watchExecutionTimeService = WatchExecutionTimeService(sessionManager: WCSessionManager.sharedInstace)
        watchExecutionTimeService.fetchExecutionTimesFunction = fetchExecutionTimesForWatch
        watchExecutionTimeService.didUpdateExecutionTime = updateExecutionTime
        WCSessionManager.sharedInstace.activate()
    }
    
    func fetchExecutionTimesForWatch() -> Array<ExecutionTimeProtocol> {
        let fetchRequest = self.executionTimeService.allChildrenExecutionTimesFetchRequest(NSDate())
        do{
            return try self.managedObjectContext.executeFetchRequest(fetchRequest) as! Array<ExecutionTimeProtocol>
        } catch {
            return  Array<ExecutionTimeProtocol>()
        }
    }

    
    func updateExecutionTime(executionTimeData: [String: NSObject]) {
        if let executionTime = executionTimeService.getExecutionTimeForCodingData(managedObjectContext, codingData: executionTimeData) {
            executionTime.updateWithCodingData(executionTimeData)
            managedObjectContext.saveOrRollback()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let managedObjectContextSettable = segue.destinationViewController as? ManagedObjectContextSettable {
            managedObjectContextSettable.managedObjectContext = managedObjectContext
        }
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = MedicationHeaderView(frame: CGRect(x: 0, y: 0, width: 300, height: 32))
        let indexPath = NSIndexPath(forRow: 0, inSection: section)
        let timeOfDay = dataProvider.objectAtIndexPath(indexPath).timeOfDay
        view.configureWithTimeOfDay(timeOfDay)
        view.backgroundColor = UIColor(red:240 / 255.0, green:240 / 255.0, blue:240 / 255.0, alpha:1.0)
        
        return view
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let executionTime = dataProvider.objectAtIndexPath(indexPath)
        let drug = executionTime.parentExecutionTime.drug
        let actionViewcontroller = UIAlertController(title: "\n\n\n\n\n\n", message: "", preferredStyle: UIAlertControllerStyle.ActionSheet)
        if let _ = executionTime.executionDate {
            let revokeMedikationAction = UIAlertAction(title: "Nicht genommen", style: .Default) { (action) in
                executionTime.executionDate = nil
            }
            actionViewcontroller.addAction(revokeMedikationAction)
        } else {
            let takeMedikationAction = UIAlertAction(title: "Genommen", style: .Default) { (_) in
                executionTime.executionDate = NSDate()
            }
            let moveToLaterAction = UIAlertAction(title: "Später nehmen", style: .Destructive) {(_) in
                self.askForDelay(executionTime)
            }
            actionViewcontroller.addAction(moveToLaterAction)
            actionViewcontroller.addAction(takeMedikationAction)
        }
        
        let cancleAction = UIAlertAction(title: "Abbrechen", style: .Cancel, handler: nil)
        
        actionViewcontroller.addAction(cancleAction)
        let detailView = ExecutionTimeDetailView(frame: actionViewcontroller.view.frame, drug: drug, executionTime: executionTime)
        actionViewcontroller.view.addSubview(detailView)
        
        self.presentViewController(actionViewcontroller, animated: true, completion: nil)
    }
    
    func askForDelay(executionTime:ExecutionTime) {
        let actionViewcontroller = UIAlertController(title: "Verschieben", message: "Wähle die Dauer, um das Medikament verschoben wird", preferredStyle: UIAlertControllerStyle.ActionSheet)
        let delay10MintesAction = UIAlertAction(title: "15 Minuten", style: .Default) {(_) in
            executionTime.secondsMoved = 900
        }
        let delay30MintesAction = UIAlertAction(title: "30 Minuten", style: .Default) {(_) in
            executionTime.secondsMoved = 1800
        }
        let delay60MintesAction = UIAlertAction(title: "60 Minuten", style: .Default) {(_) in
            executionTime.secondsMoved = 3600
        }
        let delay120MintesAction = UIAlertAction(title: "120 Minuten", style: .Default) {(_) in
            executionTime.secondsMoved = 7200
        }
        
        let cancleAction = UIAlertAction(title: "Abbrechen", style: .Cancel, handler: nil)
        
        actionViewcontroller.addAction(delay10MintesAction)
        actionViewcontroller.addAction(delay30MintesAction)
        actionViewcontroller.addAction(delay60MintesAction)
        actionViewcontroller.addAction(delay120MintesAction)
        actionViewcontroller.addAction(cancleAction)
        

        self.presentViewController(actionViewcontroller, animated: true, completion: nil)
    }
    
    @IBAction func testPush(sender: AnyObject) {
        let executionTime = dataProvider.objectAtIndexPath(NSIndexPath(forRow: 0, inSection: 0))
        guard let notification = executionTimeService.createNotification(executionTime.parentExecutionTime) else { return }
        print(notification.userInfo)
        notification.repeatInterval = .Year
        notification.fireDate = NSDate().dateByAddingTimeInterval(8)
        notification.soundName = UILocalNotificationDefaultSoundName
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    
}
