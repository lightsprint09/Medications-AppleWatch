//
//  UINavigationControllerCoreDataExtension.swift
//  Medications
//
//  Created by Lukas Schmidt on 10.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import UIKit
import CoreData

extension UINavigationController: ManagedObjectContextSettable {
    var managedObjectContext: NSManagedObjectContext! {
        get {
            return nil
        }
        
        set(context) {
            if let topViewController = topViewController as? ManagedObjectContextSettable {
                var controller = topViewController
                controller.managedObjectContext = context
            }
        }
    }

}




