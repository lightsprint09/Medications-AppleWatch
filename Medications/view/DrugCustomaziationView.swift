//
//  DrugCustomaziationView.swift
//  Medications
//
//  Created by Lukas Schmidt on 11.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import UIKit

@IBDesignable
class DrugCustomaziationView: RoundView {
    
    @IBInspectable var pillBaseColor: UIColor? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var pillSecondColor: UIColor? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var drugKind: DrugRenderEnum? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        guard let context = UIGraphicsGetCurrentContext(), let pillBaseColor = pillBaseColor, let kind = drugKind else { return }
        
        let scale =  1 / 90 * rect.height
        kind.render(context, baseColor: pillBaseColor, secondColor: pillSecondColor, scale: scale)
    }
}
