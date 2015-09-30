//
//  ExecutionTimeTableViewCell.swift
//  Medications
//
//  Created by Lukas Schmidt on 25.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import UIKit

class ExecutionTimeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dayTimeImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var doseLabel: UILabel!
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configurWithExecutionTime(execuitonTime:RootExecutionTime) {
        timeLabel.text = execuitonTime.timeString
        dayTimeImageView.image = execuitonTime.timeOfDay.imageWithColor
        doseLabel.text = execuitonTime.amountUnitString
    }

}
