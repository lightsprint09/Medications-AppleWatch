//
//  AddDrugToMedicationViewControllerExtension.swift
//  Medications
//
//  Created by Lukas Schmidt on 17.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import Foundation

class DrugDataSourceDelegate: FetchedResultsCollectionViewDataSourceDelegate {
    private static let CELL_IDENTIFIER = "add-drug-to-medication-cell"
    
    typealias Cell = AddDrugToMedicationCell
    typealias Object = Drug
    
    typealias Header = UICollectionReusableView
    typealias Footer = UICollectionReusableView
    
    func cellIdentifierForObject(object: Object) -> String {
        return DrugDataSourceDelegate.CELL_IDENTIFIER
    }
    
    func configureCell(cell: Cell, object: Object) {
//        if let selectedDrug = selectedDrug where object.isEqual(selectedDrug) {
//            cell.showSelectedBadge(true)
//        }else {
//            cell.showSelectedBadge(false)
//        }
//        
//        cell.configureWithDrug(object)
    }
    
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