//
//  DrugRenderEnum.swift
//  Medications
//
//  Created by Lukas Schmidt on 11.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import Foundation
import UIKit



enum DrugEnum: Int {
    case RoundPillWithMiddel, LongPillWithMiddel, RoundPill, LongPill, HalfPillSingeColor, HalfPillSingeColorDots, DropDose, Injection
    
    static var count: Int {
        var max = 0
        while let _ = self.init(rawValue: ++max) {}
        return max
    }
    
    func unit(count:Double) -> String {
        switch (self) {
        case RoundPillWithMiddel, LongPillWithMiddel, RoundPill, LongPill, HalfPillSingeColor, HalfPillSingeColorDots:
            if count <= 1 {
                return "Tablette"
            }
            return "Tabletten"
        case .DropDose:
            return "Tropfen"
        case .Injection:
            return "ml"
        }
    }
    
    
    
}