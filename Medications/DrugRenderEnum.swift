//
//  DrugRenderEnum.swift
//  Medications
//
//  Created by Lukas Schmidt on 11.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import Foundation
import UIKit

enum DrugRenderEnum: Int {
    case RoundPillWithMiddel, LongPillWithMiddel, RoundPill, LongPill

    
    static var count: Int {
        var max = 0
        while let _ = self.init(rawValue: ++max) {}
        return max
    }
    
    func render(context:CGContext, baseColor:UIColor, secondColor:UIColor?, scale:CGFloat = 1) {
        let darkBaseColor = UIColor(red: baseColor.red() - 0.3, green: baseColor.green() - 0.3, blue: baseColor.blue() - 0.3, alpha: 1)
        let borderColor = UIColor(red: baseColor.red() - 0.35, green: baseColor.green() - 0.35, blue: baseColor.blue() - 0.35, alpha: 1)
        let pillMiddleColor = UIColor(red: baseColor.red() - 0.4, green: baseColor.green() - 0.4, blue: baseColor.blue() - 0.4, alpha: 1)
        
        switch(self) {
        case .RoundPillWithMiddel:
            //// Gradient Declarations
            let pillBackgroundGradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [baseColor.CGColor, baseColor.blendedColorWithFraction(0.5, ofColor: darkBaseColor).CGColor, darkBaseColor.CGColor], [0, 0.81, 1])
            let pillMiddelGradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [pillMiddleColor.CGColor, pillMiddleColor.blendedColorWithFraction(0.5, ofColor: baseColor).CGColor, baseColor.CGColor, baseColor.blendedColorWithFraction(0.5, ofColor: pillMiddleColor).CGColor, pillMiddleColor.CGColor], [0, 0, 0.48, 1, 1])
            
            CGContextSaveGState(context)
            CGContextScaleCTM(context, scale, scale)
            
            //// Group
            //// Rectangle Drawing
            let rectanglePath = UIBezierPath(roundedRect: CGRectMake(15, 15, 60, 60), cornerRadius: 30)
            CGContextSaveGState(context)
            rectanglePath.addClip()
            CGContextDrawLinearGradient(context, pillBackgroundGradient, CGPointMake(45, 15), CGPointMake(45, 75), CGGradientDrawingOptions.DrawsBeforeStartLocation)
            CGContextRestoreGState(context)
            borderColor.setStroke()
            rectanglePath.lineWidth = 1
            rectanglePath.stroke()
            
            
            //// Rectangle 2 Drawing
            let rectangle2Path = UIBezierPath(rect: CGRectMake(15.5, 44.5, 59, 4))
            CGContextSaveGState(context)
            rectangle2Path.addClip()
            CGContextDrawLinearGradient(context, pillMiddelGradient, CGPointMake(45, 44.5), CGPointMake(45, 48.5), CGGradientDrawingOptions.DrawsBeforeStartLocation)
            CGContextRestoreGState(context)
        case .LongPillWithMiddel:
            //// Gradient Declarations
            
            //// Gradient Declarations
            let pillBackgroundGradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [baseColor.CGColor, baseColor.blendedColorWithFraction(0.5, ofColor: darkBaseColor).CGColor, darkBaseColor.CGColor], [0, 0.81, 1])
            let pillMiddelGradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [pillMiddleColor.CGColor, pillMiddleColor.blendedColorWithFraction(0.5, ofColor: baseColor).CGColor, baseColor.CGColor, baseColor.blendedColorWithFraction(0.5, ofColor: pillMiddleColor).CGColor, pillMiddleColor.CGColor], [0, 0, 0.48, 1, 1])
            
            //// Group
            //// Rectangle Drawing
            let rectanglePath = UIBezierPath(roundedRect: CGRectMake(29, 5, 32, 80), cornerRadius: 16)
            CGContextSaveGState(context)
            rectanglePath.addClip()
            CGContextDrawLinearGradient(context, pillBackgroundGradient, CGPointMake(45, 5), CGPointMake(45, 85), CGGradientDrawingOptions.DrawsBeforeStartLocation)
            CGContextRestoreGState(context)
            borderColor.setStroke()
            rectanglePath.lineWidth = 1
            rectanglePath.stroke()
            
            
            //// Rectangle 2 Drawing
            let rectangle2Path = UIBezierPath(rect: CGRectMake(29.5, 42.5, 31, 3))
            CGContextSaveGState(context)
            rectangle2Path.addClip()
            CGContextDrawLinearGradient(context, pillMiddelGradient, CGPointMake(45, 42.5), CGPointMake(45, 45.5), CGGradientDrawingOptions.DrawsBeforeStartLocation)
            CGContextRestoreGState(context)
        case .RoundPill:
            //// Gradient Declarations
            let pillBackgroundGradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [baseColor.CGColor, baseColor.blendedColorWithFraction(0.5, ofColor: darkBaseColor).CGColor, darkBaseColor.CGColor], [0, 0.81, 1])
            
            //// Group
            //// Rectangle Drawing
            let rectanglePath = UIBezierPath(roundedRect: CGRectMake(15, 15, 60, 60), cornerRadius: 30)
            CGContextSaveGState(context)
            rectanglePath.addClip()
            CGContextDrawLinearGradient(context, pillBackgroundGradient, CGPointMake(45, 15), CGPointMake(45, 75), CGGradientDrawingOptions.DrawsBeforeStartLocation)
            CGContextRestoreGState(context)
            borderColor.setStroke()
            rectanglePath.lineWidth = 1
            rectanglePath.stroke()
        case .LongPill:
            //// Gradient Declarations
            let pillBackgroundGradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [baseColor.CGColor, baseColor.blendedColorWithFraction(0.5, ofColor: darkBaseColor).CGColor, darkBaseColor.CGColor], [0, 0.81, 1])
            
            //// Group
            //// Rectangle Drawing
            let rectanglePath = UIBezierPath(roundedRect: CGRectMake(29, 5, 32, 80), cornerRadius: 16)
            CGContextSaveGState(context)
            rectanglePath.addClip()
            CGContextDrawLinearGradient(context, pillBackgroundGradient, CGPointMake(45, 5), CGPointMake(45, 85), CGGradientDrawingOptions.DrawsBeforeStartLocation)
            CGContextRestoreGState(context)
            borderColor.setStroke()
            rectanglePath.lineWidth = 1
            rectanglePath.stroke()
        }
        
        
    }
}