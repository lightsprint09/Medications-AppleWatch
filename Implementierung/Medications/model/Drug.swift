//
//  Drug.swift
//  Medications
//
//  Created by Lukas Schmidt on 10.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import Foundation
import CoreData

class Drug: NSManagedObject {
    var image:UIImage? {
        set{
            if let image = newValue {
                userImage = UIImagePNGRepresentation(image)
            }else {
                userImage = nil
            }
        }
        get {
            if let userImage = userImage {
                return UIImage(data: userImage)
            }
            return nil;
        }
    }
    
    var type: DrugEnum? {
        get {
            if let type = imageKind {
                return DrugEnum(rawValue: type.integerValue)
            }
            return nil
        }
        set {
            if let kind = newValue {
                imageKind = kind.rawValue
            }else {
                imageKind = nil
            }
        }
    }
}
