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
    
    func getDrugRenderType() -> DrugRenderEnum? {
        if let type = imageKind {
            return DrugRenderEnum(rawValue: type.integerValue)
        }
        return nil
    }
    
    func setDrugRenderEnum(kind:DrugRenderEnum?) {
        if let kind = kind {
            imageKind = NSNumber(integer: kind.rawValue)
        }else {
            imageKind = nil
        }
    }
}
