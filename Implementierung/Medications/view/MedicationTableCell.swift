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
        drugNameLabel.text = executionTime.medication?.drug?.name
        unitCountLabel.text = executionTime.amountUnitString
        timeLabel.text = executionTime.timeString
        if let drug = executionTime.medication?.drug {
            drugView.configureWithDrug(drug)
        }
        
        
    }
}
