//
//  FetchedResultsCollectionViewDataSourceDelegate.swift
//  Medications
//
//  Created by Lukas Schmidt on 17.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import UIKit

protocol FetchedResultsCollectionViewDataSourceDelegate: class {
    typealias Object
    typealias Cell: UICollectionViewCell
    
    func cellIdentifierForObject(object: Object) -> String
    func configureCell(cell: Cell, object: Object)
    
    typealias Header: UICollectionReusableView
    typealias Footer: UICollectionReusableView
    
    func headerIdentifierForIndexPath(indexPath: NSIndexPath) -> String
    func configureHeader(header: Header, indexPath: NSIndexPath)
    
    func footerIdentifierForIndexPath(indexPath: NSIndexPath) -> String
    func configureFooter(header: Footer, indexPath: NSIndexPath)
}
