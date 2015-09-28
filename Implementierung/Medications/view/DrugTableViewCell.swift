//
//  DrugTableViewCell.swift
//  Medications
//
//  Created by Lukas Schmidt on 10.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import UIKit

class DrugTableViewCell: UITableViewCell {
    
    @IBOutlet weak var drugView: DrugCustomaziationView!
    @IBOutlet weak var drugNameLabel: UILabel!
    @IBOutlet weak var activeSubstanceLabel: UILabel!
    func configureWithDrug(drug:Drug) {
        drugNameLabel.text = drug.name
        activeSubstanceLabel.text = drug.activeSubstance
        drugView.configureWithDrug(drug)
    }
}
