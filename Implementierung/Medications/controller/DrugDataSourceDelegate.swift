//
//  AddDrugToMedicationViewControllerExtension.swift
//  Medications
//
//  Created by Lukas Schmidt on 17.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import Foundation
import CoreDataStack

class DrugDataSourceDelegate: DataProviderDelegate, CollectionViewDataSourceDelegate  {
    typealias Object = Drug
    
    func dataProviderDidUpdate(updates: [DataProviderUpdate<Object>]?) {
        
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