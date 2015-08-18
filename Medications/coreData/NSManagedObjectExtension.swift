//
//  ManagedObjectTypeExtension.swift
//  Medications
//
//  Created by Lukas Schmidt on 10.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import CoreData

extension NSManagedObject {
    public static var entityName: String {
        let fullClassName = NSStringFromClass(object_getClass(self))
        let nameComponents = fullClassName.componentsSeparatedByString(".")
        return nameComponents.last!
    }
}