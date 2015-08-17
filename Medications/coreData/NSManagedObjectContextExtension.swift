//
//  NSManagedObjectContextExtension.swift
//  Medications
//
//  Created by Lukas Schmidt on 10.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import CoreData

extension NSManagedObjectContext {
    public func insertObject<A: NSManagedObject where A: ManagedObjectType>() -> A {
    guard let obj = NSEntityDescription.insertNewObjectForEntityForName(A.entityName, inManagedObjectContext: self) as? A else { fatalError("Wrong object type") }
    return obj
    }
    
    public func saveOrRollback() {
        do {
        try save()
    } catch {
            rollback()
        }
    }
    
    public func performChanges(block: () -> ()) {
            performBlock {
        block()
        self.saveOrRollback()
            }
    }
    
    public func createPersistentObject<A: NSManagedObject where A: ManagedObjectType>(setupBlock:(A)->()) -> A {
        let object = insertObject() as A
        setupBlock(object)
        saveOrRollback()
        return object
    }
}
 