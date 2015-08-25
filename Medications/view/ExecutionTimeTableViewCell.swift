//
//  ExecutionTimeTableViewCell.swift
//  Medications
//
//  Created by Lukas Schmidt on 25.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import UIKit

class ExecutionTimeTableViewCell: UITableViewCell {
    private static let dateFormatter = NSDateFormatter()
    
    @IBOutlet weak var dayTimeImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var doseLabel: UILabel!
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configurWithExecutionTime(execuitonTime:ExecutionTime) {
        ExecutionTimeTableViewCell.dateFormatter.dateFormat = "HH:mm"
        timeLabel.text = ExecutionTimeTableViewCell.dateFormatter.stringFromDate(execuitonTime.assignmentDate)
        dayTimeImageView.image = execuitonTime.timeOfDay.imageWithColor
        if let amount = execuitonTime.amount?.doubleValue {
            doseLabel.text = "\(amount) Tabletten"
        }
        
    }

}
