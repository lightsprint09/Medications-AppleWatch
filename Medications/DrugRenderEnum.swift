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
    case RoundPill, LongPill
    
    func render(context:CGContext, baseColor:UIColor, secondColor:UIColor?) {
        let darkBaseColor = UIColor(red: baseColor.red() - 0.3, green: baseColor.green() - 0.3, blue: baseColor.blue() - 0.3, alpha: 1)
        let borderColor = UIColor(red: baseColor.red() - 0.35, green: baseColor.green() - 0.35, blue: baseColor.blue() - 0.35, alpha: 1)
        let pillMiddleColor = UIColor(red: baseColor.red() - 0.4, green: baseColor.green() - 0.4, blue: baseColor.blue() - 0.4, alpha: 1)
        let pillBackgroundGradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [baseColor.CGColor, baseColor.blendedColorWithFraction(0.5, ofColor: darkBaseColor).CGColor, darkBaseColor.CGColor], [0, 0.81, 1])
        
        switch(self) {
        case .RoundPill:
            
            //// Gradient Declarations
            let gradient2 = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [baseColor.CGColor, baseColor.blendedColorWithFraction(0.5, ofColor: darkBaseColor).CGColor, darkBaseColor.CGColor], [0, 1, 1])!
            let gradient3 = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [darkBaseColor.CGColor, darkBaseColor.blendedColorWithFraction(0.5, ofColor: baseColor).CGColor, baseColor.CGColor, darkBaseColor.CGColor], [0, 0.24, 0.54, 1])!
            
            //// Group
            //// Rectangle Drawing
            let rectanglePath = UIBezierPath(roundedRect: CGRectMake(58, 47, 50, 50), cornerRadius: 20)
            CGContextSaveGState(context)
            rectanglePath.addClip()
            CGContextDrawLinearGradient(context, gradient2, CGPointMake(83, 45), CGPointMake(83, 99), CGGradientDrawingOptions.DrawsBeforeStartLocation)
            CGContextRestoreGState(context)
            borderColor.setStroke()
            rectanglePath.lineWidth = 1
            rectanglePath.stroke()
            
            
            //// Rectangle 2 Drawing
            let rectangle2Path = UIBezierPath(rect: CGRectMake(58.5, 69.5, 49, 4))
            CGContextSaveGState(context)
            rectangle2Path.addClip()
            CGContextDrawLinearGradient(context, gradient3, CGPointMake(83, 69.5), CGPointMake(83, 73.5), CGGradientDrawingOptions.DrawsBeforeStartLocation)
            CGContextRestoreGState(context)
        case .LongPill:
            //// Gradient Declarations
            
            let pillMiddelGradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [pillMiddleColor.CGColor, pillMiddleColor.blendedColorWithFraction(0.5, ofColor: baseColor).CGColor, baseColor.CGColor, baseColor.blendedColorWithFraction(0.5, ofColor: pillMiddleColor).CGColor, pillMiddleColor.CGColor], [0, 0, 0.48, 1, 1])
            
            //// Rectangle Drawing
            let rectanglePath = UIBezierPath(roundedRect: CGRectMake(43, 26, 32, 80), cornerRadius: 16)
            CGContextSaveGState(context)
            rectanglePath.addClip()
            CGContextDrawLinearGradient(context, pillBackgroundGradient, CGPointMake(59, 26), CGPointMake(59, 106), CGGradientDrawingOptions.DrawsBeforeStartLocation)
            CGContextRestoreGState(context)
            borderColor.setStroke()
            rectanglePath.lineWidth = 1
            rectanglePath.stroke()
            
            
            //// Rectangle 2 Drawing
            let rectangle2Path = UIBezierPath(rect: CGRectMake(43.5, 64.5, 31, 3))
            CGContextSaveGState(context)
            rectangle2Path.addClip()
            CGContextDrawLinearGradient(context, pillMiddelGradient, CGPointMake(59, 64.5), CGPointMake(59, 67.5), CGGradientDrawingOptions.DrawsBeforeStartLocation)
            CGContextRestoreGState(context)
        }
        
        
    }
}