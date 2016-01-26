//
//  MedicationTableCell.swift
//  Medications
//
//  Created by Lukas Schmidt on 26.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import UIKit
import CoreDataStack

class MedicationTableCell: UITableViewCell, ConfigurableCell {
    typealias DataSource = ExecutionTime
    
    @IBOutlet weak var unitCountLabel: UILabel!
    @IBOutlet weak var drugNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var drugImageView: UIImageView!
    @IBOutlet weak var delayView: RoundLabel!
    
    func configureForObject(object: DataSource) {
        let drug = object.parentExecutionTime.drug
        drugNameLabel.text = drug.name
        unitCountLabel.text = object.amountUnitString
        
        if let pillImageData = drug.pillImage {
            drugImageView.image = UIImage(data: pillImageData)
        }
        timeLabel.text = object.timeString
        if let executionDate = object.executionDate {
            timeLabel.textColor = .greenExecutionTimeColor()
            timeLabel.text = ExecutionTime.timeStrintFromDate(executionDate) + " ✔︎"
        } else {
            timeLabel.textColor = UIColor.blueExecutionTimeColor()
            timeLabel.text = object.timeString
        }
        
        if let delay = object.secondsMoved where object.executionDate == nil {
            delayView.text = "+\(delay.integerValue / 60)"
            delayView.hidden = false
        } else {
            delayView.hidden = true
        }
    }
    
    func configureWithExecutionTime(executionTime:ExecutionTime) {
        
    }
}
