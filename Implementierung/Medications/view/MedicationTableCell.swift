//
//  MedicationTableCell.swift
//  Medications
//
//  Created by Lukas Schmidt on 26.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import UIKit

class MedicationTableCell: UITableViewCell {
    
    @IBOutlet weak var unitCountLabel: UILabel!
    @IBOutlet weak var drugNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var drugImageView: UIImageView!
    @IBOutlet weak var delayView: RoundLabel!
    
    func configureWithExecutionTime(executionTime:ExecutionTime) {
        let drug = executionTime.parentExecutionTime.drug
        drugNameLabel.text = drug?.name
        unitCountLabel.text = executionTime.amountUnitString
        
        if let pillImageData = drug?.pillImage {
            drugImageView.image = UIImage(data: pillImageData)
        }
        timeLabel.text = executionTime.timeString
        if let executionDate = executionTime.executionDate {
            timeLabel.textColor = .greenExecutionTimeColor()
            timeLabel.text = ExecutionTime.timeStrintFromDate(executionDate) + " ✔︎"
        } else {
             timeLabel.textColor = UIColor.blueExecutionTimeColor()
            timeLabel.text = executionTime.timeString
        }
        
        if let delay = executionTime.secondsMoved where executionTime.executionDate == nil {
            delayView.text = "+\(delay.integerValue / 60)"
            delayView.hidden = false
        } else {
            delayView.hidden = true
        }
    }
}
