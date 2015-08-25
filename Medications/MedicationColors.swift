//
//  File.swift
//  Medications
//
//  Created by Lukas Schmidt on 21.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import UIKit

extension UIColor {
    static var noonTopColor: UIColor {
        get {return UIColor(red:250 / 255.0, green:217 / 255.0, blue:97 / 255.0, alpha:1.0)}
    }
    static var noonBottomColor: UIColor {
        get {return UIColor(red:247 / 255.0, green:107 / 255.0, blue:28 / 255.0, alpha:1.0)}
    }
    static var noonGradient: CAGradientLayer {
        get{
            let gradient = CAGradientLayer()
            gradient.colors = [UIColor.noonTopColor.CGColor, noonBottomColor.CGColor]
            return gradient
        }
    }
    
    static var eveningTopColor: UIColor {
        get {return UIColor(red:85 / 255.0, green:145 / 255.0, blue:219 / 255.0, alpha:1.0)}
    }
    static var eveningBottomColor: UIColor {
        get {return UIColor(red:64 / 255.0, green:44 / 255.0, blue:210 / 255.0, alpha:1.0)}
    }
    static var eveningGradient: CAGradientLayer {
        get{
            let gradient = CAGradientLayer()
            gradient.colors = [eveningTopColor.CGColor, eveningBottomColor.CGColor]
            return gradient
        }
    }
}