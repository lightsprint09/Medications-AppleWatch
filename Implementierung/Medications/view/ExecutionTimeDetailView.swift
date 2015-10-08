//
//  ExecutionTimeDetailView.swift
//  Medications
//
//  Created by Lukas Schmidt on 02.10.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import UIKit

class ExecutionTimeDetailView: UIView {
    init(frame: CGRect, drug: Drug, executionTime: ExecutionTime) {
        super.init(frame: frame)
        let imageView = UIImageView(frame: CGRect(x: (bounds.width - 70) / 2, y: 0, width: 70, height: 70))
        imageView.image = UIImage(data: drug.pillImage!)
        let drugLabel = UILabel(frame: CGRect(x: (bounds.width - 120) / 2, y: 58, width: 120, height: 32))
        drugLabel.textAlignment = .Center
        drugLabel.text = drug.name
        drugLabel.textColor = .grayColor()
        
        let detailLabel = UILabel(frame: CGRect(x: (bounds.width - 200) / 2, y: 92, width: 200, height: 32))
        detailLabel.textAlignment = .Center
        //detailLabel. bold
        detailLabel.text = executionTime.timeString + " - " + executionTime.amountUnitString!
        
        addSubview(imageView)
        addSubview(drugLabel)
        addSubview(detailLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
