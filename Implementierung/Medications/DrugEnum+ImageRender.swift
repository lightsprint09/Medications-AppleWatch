//
//  DrugEnum+ImageRender.swift
//  Medications
//
//  Created by Lukas Schmidt on 26.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import Foundation

extension DrugEnum {
    func renderToImage(size:CGSize, baseColor:UIColor, secondColor:UIColor? = nil, scale:CGFloat = 1) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0);
        let context = UIGraphicsGetCurrentContext()
        render(context!, baseColor: baseColor)
        let image = UIGraphicsGetImageFromCurrentImageContext();
        
        return image
    }
    
    func render(context:CGContext, baseColor:UIColor, secondColor:UIColor? = nil, scale:CGFloat = 1) {
        let darkBaseColor = UIColor(red: baseColor.red() - 0.3, green: baseColor.green() - 0.3, blue: baseColor.blue() - 0.3, alpha: 1)
        let borderColor = UIColor(red: baseColor.red() - 0.35, green: baseColor.green() - 0.35, blue: baseColor.blue() - 0.35, alpha: 1)
        let pillMiddleColor = UIColor(red: baseColor.red() - 0.4, green: baseColor.green() - 0.4, blue: baseColor.blue() - 0.4, alpha: 1)
        CGContextSaveGState(context)
        CGContextScaleCTM(context, scale, scale)
        switch(self) {
        case .RoundPillWithMiddel:
            //// Gradient Declarations
            let pillBackgroundGradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [baseColor.CGColor, baseColor.blendedColorWithFraction(0.5, ofColor: darkBaseColor).CGColor, darkBaseColor.CGColor], [0, 0.81, 1])
            let pillMiddelGradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [pillMiddleColor.CGColor, pillMiddleColor.blendedColorWithFraction(0.5, ofColor: baseColor).CGColor, baseColor.CGColor, baseColor.blendedColorWithFraction(0.5, ofColor: pillMiddleColor).CGColor, pillMiddleColor.CGColor], [0, 0, 0.48, 1, 1])
            
            
            
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
        case .HalfPillSingeColor:
            let darkBaseColor = UIColor(red: baseColor.red() - 0.1, green: baseColor.green() - 0.1, blue: baseColor.blue() - 0.1, alpha: 1)
            //// Rectangle Drawing
            let rectanglePath = UIBezierPath(roundedRect: CGRectMake(27, 5, 36, 80), cornerRadius: 12)
            baseColor.setFill()
            rectanglePath.fill()
            borderColor.setStroke()
            rectanglePath.lineWidth = 1
            rectanglePath.stroke()
            
            
            //// Rectangle 2 Drawing
            let rectangle2Path = UIBezierPath(roundedRect: CGRectMake(27, 45, 36, 40), byRoundingCorners: UIRectCorner.BottomLeft.union(UIRectCorner.BottomRight) , cornerRadii: CGSizeMake(12, 12))
            rectangle2Path.closePath()
            darkBaseColor.setFill()
            rectangle2Path.fill()
        case .HalfPillSingeColorDots:
            let rectanglePath = UIBezierPath(roundedRect: CGRectMake(27, 5, 36, 80), cornerRadius: 12)
            baseColor.setFill()
            rectanglePath.fill()
            borderColor.setStroke()
            rectanglePath.lineWidth = 1
            rectanglePath.stroke()
            
            
            //// Rectangle 2 Drawing
            let rectangle2Path = UIBezierPath(roundedRect: CGRectMake(27, 45, 36, 40), byRoundingCorners: UIRectCorner.BottomLeft.union(UIRectCorner.BottomRight), cornerRadii: CGSizeMake(12, 12))
            rectangle2Path.closePath()
            darkBaseColor.setFill()
            rectangle2Path.fill()
            
            
            //// Oval 12 Drawing
            let oval12Path = UIBezierPath(ovalInRect: CGRectMake(31, 14, 5, 5))
            darkBaseColor.setFill()
            oval12Path.fill()
            
            
            //// Oval 13 Drawing
            let oval13Path = UIBezierPath(ovalInRect: CGRectMake(39, 9, 5, 5))
            darkBaseColor.setFill()
            oval13Path.fill()
            
            
            //// Oval 14 Drawing
            let oval14Path = UIBezierPath(ovalInRect: CGRectMake(56, 19, 5, 5))
            darkBaseColor.setFill()
            oval14Path.fill()
            
            
            //// Oval 15 Drawing
            let oval15Path = UIBezierPath(ovalInRect: CGRectMake(54, 27, 5, 5))
            darkBaseColor.setFill()
            oval15Path.fill()
            
            
            //// Oval 16 Drawing
            let oval16Path = UIBezierPath(ovalInRect: CGRectMake(36, 22, 5, 5))
            darkBaseColor.setFill()
            oval16Path.fill()
            
            
            //// Oval 17 Drawing
            let oval17Path = UIBezierPath(ovalInRect: CGRectMake(46, 19, 5, 5))
            darkBaseColor.setFill()
            oval17Path.fill()
            
            
            //// Oval 18 Drawing
            let oval18Path = UIBezierPath(ovalInRect: CGRectMake(39, 34, 5, 5))
            darkBaseColor.setFill()
            oval18Path.fill()
            
            
            //// Oval 19 Drawing
            let oval19Path = UIBezierPath(ovalInRect: CGRectMake(44, 28, 5, 5))
            darkBaseColor.setFill()
            oval19Path.fill()
            
            
            //// Oval 20 Drawing
            let oval20Path = UIBezierPath(ovalInRect: CGRectMake(49, 9, 5, 5))
            darkBaseColor.setFill()
            oval20Path.fill()
            
            
            //// Oval Drawing
            let ovalPath = UIBezierPath(ovalInRect: CGRectMake(31, 28, 5, 5))
            darkBaseColor.setFill()
            ovalPath.fill()
            
            
            //// Oval 2 Drawing
            let oval2Path = UIBezierPath(ovalInRect: CGRectMake(53, 36, 5, 5))
            darkBaseColor.setFill()
            oval2Path.fill()
            
            
            //// Oval 3 Drawing
            let oval3Path = UIBezierPath(ovalInRect: CGRectMake(30, 36, 5, 5))
            darkBaseColor.setFill()
            oval3Path.fill()
            
            
            //// Oval 4 Drawing
            let oval4Path = UIBezierPath(ovalInRect: CGRectMake(44, 39, 5, 5))
            darkBaseColor.setFill()
            oval4Path.fill()
        case .DropDose:
            
            
            //// Gradient Declarations
            let pillBackgroundGradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [baseColor.CGColor, baseColor.blendedColorWithFraction(0.5, ofColor: darkBaseColor).CGColor, darkBaseColor.CGColor], [0, 0.81, 1])
            
            //// Rectangle Drawing
            let rectanglePath = UIBezierPath(rect: CGRectMake(26, 42, 18, 25))
            darkBaseColor.setFill()
            rectanglePath.fill()
            
            
            //// Bezier Drawing
            let bezierPath = UIBezierPath()
            bezierPath.moveToPoint(CGPointMake(19.89, 56.98))
            bezierPath.addCurveToPoint(CGPointMake(45.57, 75.06), controlPoint1: CGPointMake(19.89, 68.26), controlPoint2: CGPointMake(33.7, 75.06))
            bezierPath.addCurveToPoint(CGPointMake(71.25, 56.85), controlPoint1: CGPointMake(57.45, 75.06), controlPoint2: CGPointMake(71.25, 68.13))
            bezierPath.addCurveToPoint(CGPointMake(45.57, 16.47), controlPoint1: CGPointMake(71.25, 41.47), controlPoint2: CGPointMake(51.82, 32.66))
            bezierPath.addCurveToPoint(CGPointMake(19.89, 56.98), controlPoint1: CGPointMake(39.06, 32.66), controlPoint2: CGPointMake(19.89, 41.6))
            bezierPath.closePath()
            bezierPath.moveToPoint(CGPointMake(38.89, 65.85))
            bezierPath.addCurveToPoint(CGPointMake(26.76, 56.98), controlPoint1: CGPointMake(31.59, 65.58), controlPoint2: CGPointMake(26.8, 61.27))
            bezierPath.addCurveToPoint(CGPointMake(32.27, 43.8), controlPoint1: CGPointMake(26.73, 52.69), controlPoint2: CGPointMake(29.72, 47.2))
            bezierPath.addCurveToPoint(CGPointMake(36.49, 43.8), controlPoint1: CGPointMake(33.94, 41.43), controlPoint2: CGPointMake(37.23, 41.95))
            bezierPath.addCurveToPoint(CGPointMake(34.25, 56.42), controlPoint1: CGPointMake(35.04, 47.22), controlPoint2: CGPointMake(34.25, 52.43))
            bezierPath.addCurveToPoint(CGPointMake(38.89, 63.11), controlPoint1: CGPointMake(34.25, 59.33), controlPoint2: CGPointMake(36.1, 62.15))
            bezierPath.addCurveToPoint(CGPointMake(38.89, 65.85), controlPoint1: CGPointMake(41.67, 64.08), controlPoint2: CGPointMake(42.37, 65.72))
            bezierPath.closePath()
            bezierPath.miterLimit = 4;
            
            CGContextSaveGState(context)
            bezierPath.addClip()
            CGContextDrawLinearGradient(context, pillBackgroundGradient, CGPointMake(45.57, 16.47), CGPointMake(45.57, 75.06), CGGradientDrawingOptions.DrawsBeforeStartLocation)
            CGContextRestoreGState(context)
            
        case .Injection:
            //// Color Declarations
            let fillColor = pillMiddleColor
            let fillColor2 = baseColor
            
            //// glyphicons-493-medicine.svg Group
            let bezierPath = UIBezierPath()
            bezierPath.moveToPoint(CGPointMake(56, 72))
            bezierPath.addCurveToPoint(CGPointMake(62, 66), controlPoint1: CGPointMake(59.31, 72), controlPoint2: CGPointMake(62, 69.31))
            bezierPath.addLineToPoint(CGPointMake(62, 33))
            bezierPath.addCurveToPoint(CGPointMake(56, 27), controlPoint1: CGPointMake(62, 29.69), controlPoint2: CGPointMake(59.31, 27))
            bezierPath.addLineToPoint(CGPointMake(53, 27))
            bezierPath.addLineToPoint(CGPointMake(53, 21))
            bezierPath.addLineToPoint(CGPointMake(50, 21))
            bezierPath.addLineToPoint(CGPointMake(50, 6))
            bezierPath.addLineToPoint(CGPointMake(44, 12))
            bezierPath.addLineToPoint(CGPointMake(44, 21))
            bezierPath.addLineToPoint(CGPointMake(41, 21))
            bezierPath.addLineToPoint(CGPointMake(41, 27))
            bezierPath.addLineToPoint(CGPointMake(38, 27))
            bezierPath.addCurveToPoint(CGPointMake(32, 33), controlPoint1: CGPointMake(34.69, 27), controlPoint2: CGPointMake(32, 29.69))
            bezierPath.addLineToPoint(CGPointMake(32, 66))
            bezierPath.addCurveToPoint(CGPointMake(38, 72), controlPoint1: CGPointMake(32, 69.31), controlPoint2: CGPointMake(34.69, 72))
            bezierPath.addLineToPoint(CGPointMake(41, 72))
            bezierPath.addLineToPoint(CGPointMake(41, 78))
            bezierPath.addLineToPoint(CGPointMake(32, 78))
            bezierPath.addLineToPoint(CGPointMake(32, 81))
            bezierPath.addCurveToPoint(CGPointMake(35, 84), controlPoint1: CGPointMake(32, 82.65), controlPoint2: CGPointMake(33.35, 84))
            bezierPath.addLineToPoint(CGPointMake(59, 84))
            bezierPath.addCurveToPoint(CGPointMake(62, 81), controlPoint1: CGPointMake(60.65, 84), controlPoint2: CGPointMake(62, 82.65))
            bezierPath.addLineToPoint(CGPointMake(62, 78))
            bezierPath.addLineToPoint(CGPointMake(53, 78))
            bezierPath.addLineToPoint(CGPointMake(53, 72))
            bezierPath.addLineToPoint(CGPointMake(56, 72))
            bezierPath.closePath()
            bezierPath.moveToPoint(CGPointMake(38, 33))
            bezierPath.addLineToPoint(CGPointMake(56, 33))
            bezierPath.addLineToPoint(CGPointMake(56, 39))
            bezierPath.addLineToPoint(CGPointMake(47, 39))
            bezierPath.addLineToPoint(CGPointMake(47, 42))
            bezierPath.addLineToPoint(CGPointMake(56, 42))
            bezierPath.addLineToPoint(CGPointMake(56, 48))
            bezierPath.addLineToPoint(CGPointMake(47, 48))
            bezierPath.addLineToPoint(CGPointMake(47, 51))
            bezierPath.addLineToPoint(CGPointMake(56, 51))
            bezierPath.addLineToPoint(CGPointMake(56, 57))
            bezierPath.addLineToPoint(CGPointMake(47, 57))
            bezierPath.addLineToPoint(CGPointMake(47, 60))
            bezierPath.addLineToPoint(CGPointMake(56, 60))
            bezierPath.addLineToPoint(CGPointMake(56, 66))
            bezierPath.addLineToPoint(CGPointMake(38, 66))
            bezierPath.addLineToPoint(CGPointMake(38, 33))
            bezierPath.closePath()
            bezierPath.miterLimit = 4;
            
            fillColor.setFill()
            bezierPath.fill()
            
            
            
            
            //// Group 6
            
            
            //// Group 7
            CGContextSaveGState(context)
            CGContextSetAlpha(context, 0.3)
            CGContextBeginTransparencyLayer(context, nil)
            
            
            //// Bezier 4 Drawing
            let bezier4Path = UIBezierPath()
            bezier4Path.moveToPoint(CGPointMake(56, 39))
            bezier4Path.addLineToPoint(CGPointMake(47, 39))
            bezier4Path.addLineToPoint(CGPointMake(47, 42))
            bezier4Path.addLineToPoint(CGPointMake(56, 42))
            bezier4Path.addLineToPoint(CGPointMake(56, 48))
            bezier4Path.addLineToPoint(CGPointMake(47, 48))
            bezier4Path.addLineToPoint(CGPointMake(47, 51))
            bezier4Path.addLineToPoint(CGPointMake(56, 51))
            bezier4Path.addLineToPoint(CGPointMake(56, 57))
            bezier4Path.addLineToPoint(CGPointMake(47, 57))
            bezier4Path.addLineToPoint(CGPointMake(47, 60))
            bezier4Path.addLineToPoint(CGPointMake(56, 60))
            bezier4Path.addLineToPoint(CGPointMake(56, 66))
            bezier4Path.addLineToPoint(CGPointMake(38, 66))
            bezier4Path.addLineToPoint(CGPointMake(38, 33))
            bezier4Path.addLineToPoint(CGPointMake(56, 33))
            bezier4Path.addLineToPoint(CGPointMake(56, 39))
            bezier4Path.closePath()
            bezier4Path.miterLimit = 4;
            
            fillColor2.setFill()
            bezier4Path.fill()
            
            
            CGContextEndTransparencyLayer(context)
            CGContextRestoreGState(context)

        }
        
        
    }
}