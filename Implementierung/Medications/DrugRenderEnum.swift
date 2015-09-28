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
    
    func unit(count: Float) -> String {
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
    
    func unitSteps() -> Float {
        switch (self) {
        case RoundPillWithMiddel, LongPillWithMiddel, RoundPill, LongPill, HalfPillSingeColor, HalfPillSingeColorDots:
            return 0.25
        case .DropDose, .Injection:
            return 1
        }
    }
    
    func unitPreSets( count:Float = 0) -> Array<Float> {
        let c = round(count + 1)
        
        switch (self) {
        case RoundPillWithMiddel, LongPillWithMiddel, RoundPill, LongPill, HalfPillSingeColor, HalfPillSingeColorDots:
            return [c * 0.25, c * 0.5, c * 1, c * 2]
        case .DropDose, .Injection:
            return [c * 5, c * 10, c * 20, c * 25]
        }
    }
    
    
    
}