//
//  DataProvider.swift
//  Moody
//
//  Created by Florian on 08/05/15.
//  Copyright (c) 2015 objc.io. All rights reserved.
//

import UIKit


public  protocol DataProvider: class {
    typealias Object
    func objectAtIndexPath(indexPath: NSIndexPath) -> Object
    func numberOfItemsInSection(section: Int) -> Int
    func numberOfSections() -> Int
}


public  protocol DataProviderDelegate: class {
    typealias Object
    func dataProviderDidUpdate(updates: [DataProviderUpdate<Object>]?)
}


public  enum DataProviderUpdate<Object> {
    case Insert(NSIndexPath)
    case Update(NSIndexPath, Object)
    case Move(NSIndexPath, NSIndexPath)
    case Delete(NSIndexPath)
}

