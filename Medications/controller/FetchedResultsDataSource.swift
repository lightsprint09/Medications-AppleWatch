//
//  FetchedResultsDataSource.swift
//  Medications
//
//  Created by Lukas Schmidt on 10.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import CoreData
import UIKit

class FetchedResultsDataSource<D: FetchedResultsDataSourceDelegate>:NSObject, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    weak var delegate:D!
    let tableView:UITableView
    let fetchedResultsController:NSFetchedResultsController
    
    init(tableView: UITableView,
        fetchedResultsController: NSFetchedResultsController,
        delegate: D)
    {
        self.fetchedResultsController = fetchedResultsController
        self.delegate = delegate
        self.tableView = tableView
        super.init()
        fetchedResultsController.delegate = self
        tableView.dataSource = self
        try! fetchedResultsController.performFetch()
        tableView.reloadData()
    }
    
    @objc func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sec = fetchedResultsController.sections?[section] else { return 0 }
        return sec.numberOfObjects
    }
    
    
    @objc func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let object = objectAtIndexPath(indexPath)
        let identifier = self.delegate.cellIdentifierForObject(object)
        guard let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as? D.Cell else {
            fatalError("Unexpected cell type at \(indexPath)") }
        delegate.configureCell(cell, object: object)
        return cell
    }
    
    private func objectAtIndexPath(indexPath:NSIndexPath) ->D.Object {
        return fetchedResultsController.objectAtIndexPath(indexPath) as! D.Object
    }
    
    @objc func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 1
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        
        switch(type) {
        case .Insert:
            guard let newIndexPath = newIndexPath else {return}
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: UITableViewRowAnimation.Automatic);
            
        case .Delete:
             guard let indexPath = indexPath else {return}
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            
        case .Update:
            guard let indexPath = indexPath, let anObject = anObject as? D.Object, let cell = tableView.cellForRowAtIndexPath(indexPath) as? D.Cell else {return}
            delegate.configureCell(cell, object: anObject)
            
        case .Move:
            guard let newIndexPath = newIndexPath, let indexPath = indexPath else {return}
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: UITableViewRowAnimation.Automatic);
    }
}
    
    
    
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        switch(type) {
        case .Insert:
            tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: UITableViewRowAnimation.Automatic)
            
        case .Delete:
            tableView.deleteSections(NSIndexSet(index:sectionIndex), withRowAnimation: UITableViewRowAnimation.Automatic)
        default:
            print("unexpted value")
        }
        
    }
    
    
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates();
    }
    
    
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates();
    }
}
