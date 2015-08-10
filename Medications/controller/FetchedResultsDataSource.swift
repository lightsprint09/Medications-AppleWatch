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
}
