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
    @IBOutlet weak var drugView: DrugCustomaziationView!
    
    func configureWithExecutionTime(executionTime:ExecutionTime) {
        let drug = executionTime.parentExecutionTime.drug
        drugNameLabel.text = drug?.name
        unitCountLabel.text = executionTime.amountUnitString
        
        if let drug2 = drug {
            drugView.configureWithDrug(drug2)
        }
        timeLabel.text = executionTime.timeString
        if let executionDate = executionTime.executionDate {
            timeLabel.textColor = .greenExecutionTimeColor()
            timeLabel.text = "Genommen " + ExecutionTime.timeStrintFromDate(executionDate)
        } else {
             timeLabel.textColor = UIColor.blueExecutionTimeColor()
            timeLabel.text = executionTime.timeString
        }
    }
}
