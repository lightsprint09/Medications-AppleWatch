//
//  FetchedResultsCollectionViewController.swift
//  Medications
//
//  Created by Lukas Schmidt on 17.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import UIKit
import CoreData

class FetchedResultsCollectionViewController<D: FetchedResultsCollectionViewDataSourceDelegate>:NSObject, UICollectionViewDataSource, NSFetchedResultsControllerDelegate {
    weak var delegate:D!
    let collectionView:UICollectionView
    let fetchedResultsController:NSFetchedResultsController
    
    init(collectionView: UICollectionView,
        fetchedResultsController: NSFetchedResultsController,
        delegate: D)
    {
        self.fetchedResultsController = fetchedResultsController
        self.delegate = delegate
        self.collectionView = collectionView
        super.init()
        fetchedResultsController.delegate = self
        collectionView.dataSource = self
        try! fetchedResultsController.performFetch()
        collectionView.reloadData()
    }
    
    @objc func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sec = fetchedResultsController.sections?[section] else { return 0 }
        return sec.numberOfObjects
    }
    
    @objc func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let object = objectAtIndexPath(indexPath)
        let identifier = delegate.cellIdentifierForObject(object)
        guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as? D.Cell else {
            fatalError("Unexpected cell type at \(indexPath)") }
        delegate.configureCell(cell, object: object)
        return cell
    }
    
    @objc func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return fetchedResultsController.sections?.count ?? 1
    }

    
    func objectAtIndexPath(indexPath:NSIndexPath) ->D.Object {
        return fetchedResultsController.objectAtIndexPath(indexPath) as! D.Object
    }
    
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch(type) {
        case .Insert:
            guard let newIndexPath = newIndexPath else {return}
            collectionView.insertItemsAtIndexPaths([newIndexPath])
            
        case .Delete:
            guard let indexPath = indexPath else {return}
            collectionView.deleteItemsAtIndexPaths([indexPath])
            
        case .Update:
            guard let indexPath = indexPath, let anObject = anObject as? D.Object, let cell = collectionView.cellForItemAtIndexPath(indexPath) as? D.Cell else {return}
            delegate.configureCell(cell, object: anObject)
            
        case .Move:
            guard let newIndexPath = newIndexPath, let indexPath = indexPath else {return}
            collectionView.moveItemAtIndexPath(indexPath, toIndexPath: newIndexPath)
        }
    }
    
    
    
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        switch(type) {
        case .Insert:
            collectionView.insertSections(NSIndexSet(index: sectionIndex))
            
        case .Delete:
            collectionView.deleteSections(NSIndexSet(index:sectionIndex))
        default:
            print("unexpted value")
        }
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        switch(kind) {
        case UICollectionElementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: delegate.headerIdentifierForIndexPath(indexPath), forIndexPath: indexPath) as! D.Header
            delegate.configureHeader(headerView, indexPath: indexPath)
            return headerView
        
        case UICollectionElementKindSectionFooter:
        let footerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: delegate.footerIdentifierForIndexPath(indexPath), forIndexPath: indexPath) as! D.Footer
        delegate.configureFooter(footerView, indexPath: indexPath)
            return footerView
        default:
            return UICollectionReusableView()
        }
    }

}
