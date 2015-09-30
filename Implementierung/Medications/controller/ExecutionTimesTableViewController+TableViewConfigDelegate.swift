//
//  MedicationTableView+TableViewConfigDelegate.swift
//  Medications
//
//  Created by Lukas Schmidt on 26.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import Foundation

extension ExecutionTimesTableViewController: FetchedResultsDataSourceDelegate {
    private static let CELL_IDENTIFIER = "medication-cell"
    
    typealias Cell = MedicationTableCell
    typealias Object = ExecutionTime
    
    func cellIdentifierForObject(object: Object) -> String {
        return ExecutionTimesTableViewController.CELL_IDENTIFIER
    }
    
    func configureCell(cell: Cell, object: Object) {
        cell.configureWithExecutionTime(object)
    }
}