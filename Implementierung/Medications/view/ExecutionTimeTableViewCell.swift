//
//  ExecutionTimeTableViewCell.swift
//  Medications
//
//  Created by Lukas Schmidt on 25.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import UIKit
import CoreDataStack

class ExecutionTimeTableViewCell: UITableViewCell, ConfigurableCell {
    typealias DataSource = RootExecutionTime
    
    @IBOutlet weak var dayTimeImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var doseLabel: UILabel!
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureForObject(object: DataSource) {
        timeLabel.text = object.timeString
        dayTimeImageView.image = object.timeOfDay.imageWithColor
        doseLabel.text = object.amountUnitString
    }
    
    func configurWithExecutionTime(execuitonTime:RootExecutionTime) {
    }

}
