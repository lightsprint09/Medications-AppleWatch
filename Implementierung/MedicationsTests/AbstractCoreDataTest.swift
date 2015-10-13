//
//  AbstractCoreDataTest.swift
//  Medications
//
//  Created by Lukas Schmidt on 12.10.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import XCTest
import CoreData


class AbstractCoreDataTest: XCTestCase {
    var managedObjectContext: NSManagedObjectContext {
        if AbstractCoreDataTest.managedObjectContextInstance == nil {
            AbstractCoreDataTest.managedObjectContextInstance = managedObjectContextForTesting()
        }
        return AbstractCoreDataTest.managedObjectContextInstance
    }
    private static var managedObjectContextInstance: NSManagedObjectContext!
    
    func managedObjectContextForTesting() -> NSManagedObjectContext {
        let context = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        let modelURL = NSBundle.mainBundle().URLForResource("Medications", withExtension: "momd")
        print(modelURL)
        let model = NSManagedObjectModel(contentsOfURL: modelURL!)
        context.persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model!)
        do {
            try context.persistentStoreCoordinator?.addPersistentStoreWithType(NSInMemoryStoreType, configuration: nil, URL: nil, options: nil)
        }
        catch  {
            
        }
        
        
        return context
    }

}
