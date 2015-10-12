//
//  ExecutionTimesServiceTest.swift
//  Medications
//
//  Created by Lukas Schmidt on 12.10.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import XCTest
import CoreData

class ExecutionTimesServiceTest: XCTestCase {
    let executionTimeService = ExecutionTimeService()
    var managedObjectContext: NSManagedObjectContext!
    
    override func setUp() {
        managedObjectContext = managedObjectContextForTesting()
    }
    
    func managedObjectContextForTesting() -> NSManagedObjectContext {
        let context = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        let model = NSManagedObjectModel(contentsOfURL: (NSBundle.mainBundle().URLForResource("Medications", withExtension: "momd")!))
        context.persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model!)
        try! context.persistentStoreCoordinator?.addPersistentStoreWithType(NSInMemoryStoreType, configuration: nil, URL: nil, options: nil)
        
        return context
    }

}
