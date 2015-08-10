//
//  DrugTableViewControllerCellConfigure.swift
//  Medications
//
//  Created by Lukas Schmidt on 10.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import Foundation

extension DrugTableViewController: FetchedResultsDataSourceDelegate {
    private static let CELL_IDENTIFIER = "drug-cell"
    
    typealias Cell = DrugTableViewCell
    typealias Object = Drug
    
    func cellIdentifierForObject(object: Object) -> String {
        return DrugTableViewController.CELL_IDENTIFIER
    }
    
    func configureCell(cell: Cell, object: Object) {
        cell.configureWithDrug(object)
    }
}