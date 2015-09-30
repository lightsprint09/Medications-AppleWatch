//
//  ExecutionTimeTableViewDataSource.swift
//  Medications
//
//  Created by Lukas Schmidt on 25.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import UIKit

class ExecutionTimeTableViewDataSourceDelegate: NSObject, FetchedResultsDataSourceDelegate {
    private static let CELL_IDENTIFIER = "new-medication-cell"
    
    typealias Cell = ExecutionTimeTableViewCell
    typealias Object = RootExecutionTime
    
    func cellIdentifierForObject(object: Object) -> String {
        return ExecutionTimeTableViewDataSourceDelegate.CELL_IDENTIFIER
    }
    
    func configureCell(cell: Cell, object: Object) {
        cell.configurWithExecutionTime(object)
    }
}
