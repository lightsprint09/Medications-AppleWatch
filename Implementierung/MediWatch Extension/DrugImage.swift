//
//  DrugImage.swift
//  Medications
//
//  Created by Lukas Schmidt on 05.10.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import UIKit

class DrugImage: UIImage {
    
    
    var pillBaseColor: UIColor!
    var drugKind: DrugEnum!
    
    init(rect: CGRect, color:UIColor, drugkind:DrugEnum) {
        super.init()
        pillBaseColor = color
        self.drugKind = drugkind
        self.drawInRect(rect)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawInRect(rect: CGRect) {
        super.drawInRect(rect)
        guard let context = UIGraphicsGetCurrentContext(), let pillBaseColor = pillBaseColor else { return }
        
        let scale =  1 / 90 * rect.height
        drugKind.render(context, baseColor: pillBaseColor, secondColor: nil, scale: scale)
    }
}
