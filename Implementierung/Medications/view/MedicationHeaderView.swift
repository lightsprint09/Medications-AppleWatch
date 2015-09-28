//
//  MedicationHeaderView.swift
//  Medications
//
//  Created by Lukas Schmidt on 27.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import UIKit

class MedicationHeaderView: UIView {
    var timeOfDayImageView: UIImageView!
    var timeOfDayLabel: UILabel!
    var timeLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        timeOfDayImageView = UIImageView(frame: CGRect(x: 6, y: 2, width: frame.height - 4, height: frame.height - 2))
        timeOfDayImageView.contentMode = UIViewContentMode.Center
        addSubview(timeOfDayImageView)
        timeOfDayLabel = UILabel(frame: CGRect(x: frame.height + 8, y: 0, width: 80, height: frame.height))
        addSubview(timeOfDayLabel)
        
    }
    
    func configureWithTimeOfDay(timeOfDay:TimeOfDay) {
        timeOfDayImageView.image = timeOfDay.imageWithColor
        timeOfDayLabel.text = timeOfDay.toString
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
