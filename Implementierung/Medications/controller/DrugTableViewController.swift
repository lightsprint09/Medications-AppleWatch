//
//  DrugTableViewController.swift
//  Medications
//
//  Created by Lukas Schmidt on 10.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import UIKit
import CoreData
import CoreDataStack

extension DrugTableViewController: DataProviderDelegate, DataSourceDelegate {
    typealias Object = Drug
    
    func dataProviderDidUpdate(updates: [DataProviderUpdate<Object>]?) {
        
    }
    
    func cellIdentifierForObject(object: Object) -> String {
        return "drug-cell"
    }
}

class DrugTableViewController: UITableViewController, ManagedObjectContextSettable {
    var managedObjectContext: NSManagedObjectContext!
    var drugDataProvider: FetchedResultsDataProvider<DrugTableViewController>!
    var tableViewDataSource: TableViewDataSource<DrugTableViewController, FetchedResultsDataProvider<DrugTableViewController>, DrugTableViewCell>!
    let drugService = DrugDBService()
    
    override func viewDidLoad() {
        let frc = NSFetchedResultsController(fetchRequest: drugService.sortedFetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        drugDataProvider = FetchedResultsDataProvider(fetchedResultsController: frc, delegate: self)
        tableViewDataSource = TableViewDataSource(tableView: tableView, dataProvider: drugDataProvider, delegate: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let drugSettabel = (segue.destinationViewController as? UINavigationController)?.topViewController as? DrugSettable, let indexPath = tableView.indexPathForSelectedRow  {
            drugSettabel.drug = drugDataProvider.objectAtIndexPath(indexPath)
        }
        guard let addDrugVC = (segue.destinationViewController as? UINavigationController)?.topViewController as? ManagedObjectContextSettable else {return}
        var vc = addDrugVC
        vc.managedObjectContext = managedObjectContext
    }
}
