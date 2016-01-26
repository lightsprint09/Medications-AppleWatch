//
//  NSManagedObjectContextExtension.swift
//  Medications
//
//  Created by Lukas Schmidt on 10.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import CoreData
import Foundation

extension NSManagedObjectContext {
//    func insertObject<A: NSManagedObject>() -> A {
//        guard let obj = NSEntityDescription.insertNewObjectForEntityForName(A.entityName, inManagedObjectContext: self) as? A
//        else {
//            fatalError("Wrong object type")
//        }
//        
//        return obj
//    }
//    
//    public func saveOrRollback() {
//        do {
//            try save()
//        } catch  {
//            print(error)
//            rollback()
//        }
//    }
//    
//    public func performChanges(block: () -> ()) {
//        performBlock {
//            block()
//            self.saveOrRollback()
//        }
//    }
//    
//    public func createPersistentObject<A: NSManagedObject >(setupBlock:(A)->()) -> A {
//        let object = insertObject() as A
//        setupBlock(object)
//        saveOrRollback()
//        
//        return object
//    }
}
 