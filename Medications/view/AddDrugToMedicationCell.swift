//
//  AddDrugToMEdicationCell.swift
//  Medications
//
//  Created by Lukas Schmidt on 17.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import UIKit

class AddDrugToMedicationCell: UICollectionViewCell {
    @IBOutlet weak var drugNamelLabel: UILabel!
    @IBOutlet weak var drugView: DrugCustomaziationView!
    func configureWithDrug(drug:Drug) {
       drugNamelLabel.text = drug.name
        drugView.configureWithDrug(drug)
    }
}
