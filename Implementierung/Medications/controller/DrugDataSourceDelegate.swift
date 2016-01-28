//
//  AddDrugToMedicationViewControllerExtension.swift
//  Medications
//
//  Created by Lukas Schmidt on 17.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import Foundation
import CoreData
import CoreDataStack

class DrugDataSource: DataProviderDelegate, CollectionViewDataSourceDelegate  {
    typealias Object = Drug
    var drugDataProvider: FetchedResultsDataProvider<DrugDataSource>!
    var drugCollectionViewDataSource: CollectionViewDataSource<DrugDataSource, FetchedResultsDataProvider<DrugDataSource>, AddDrugToMedicationCell>!
   
    init(collectionView: UICollectionView, managedObjectContext: NSManagedObjectContext) {
        let drugService = DrugDBService()
        let fetchRequest = drugService.sortedFetchRequest()
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext)
        drugDataProvider = FetchedResultsDataProvider(fetchedResultsController: frc, delegate: self)
        drugCollectionViewDataSource = CollectionViewDataSource(collectionView: collectionView, dataProvider: drugDataProvider, delegate: self)
    }
    
    func dataProviderDidUpdate(updates: [DataProviderUpdate<Object>]?) {
        drugCollectionViewDataSource.processUpdates(updates)
    }
    
    func cellIdentifierForObject(object: Object) -> String {
        return "add-drug-to-medication-cell"
    }
    
    typealias Header = UICollectionReusableView
    typealias Footer = UICollectionReusableView
    

    
    func headerIdentifierForIndexPath(indexPath: NSIndexPath) -> String {
        return "add-drug-header-view"
    }
    
    func configureHeader(header: Header, indexPath: NSIndexPath) {
       
    }
    
    func footerIdentifierForIndexPath(indexPath: NSIndexPath) -> String {
        return ""
    }
    func configureFooter(header: Footer, indexPath: NSIndexPath) {
    }
    
}