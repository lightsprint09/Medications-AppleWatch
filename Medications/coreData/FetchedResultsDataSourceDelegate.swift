//
//  FetchedResultsDataSourceDelegate.swift
//  Medications
//
//  Created by Lukas Schmidt on 10.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import UIKit

protocol FetchedResultsDataSourceDelegate : class {
    typealias Object
    typealias Cell: UITableViewCell
    
    func cellIdentifierForObject(object: Object) -> String
    func configureCell(cell: Cell, object: Object)
}