//
//  Drug.swift
//  Medications
//
//  Created by Lukas Schmidt on 10.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import UIKit
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
            return DrugEnum(rawValue: imageKind?.integerValue ?? -1)
        }
        set {
            imageKind = newValue?.rawValue ?? nil
        }
    }
    
//    var rgb: (Float, Float, Float)? {
//        get {
//            guard let color = self.color else { return nil }
//            return (Float(color.red()), Float(color.green()), Float(color.blue()))
//        }
//        set {
//            
//        }
//    }
}
