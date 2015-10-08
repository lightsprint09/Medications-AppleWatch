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
    @IBOutlet weak var drugImageView: UIImageView!
    @IBOutlet weak var selectedView: UIView!
    
    func configureWithDrug(drug:Drug) {
       drugNamelLabel.text = drug.name
        if let pillImageData = drug.pillImage {
            drugImageView.image = UIImage(data: pillImageData)
        }
    }
    
    func showSelectedBadge(isSelected:Bool) {
        selectedView.hidden = !isSelected
        
        backgroundColor =  isSelected ? UIColor(red:230 / 255.0, green:230 / 255.0, blue:230 / 255.0, alpha:1.0) : nil
    }
    
    
}
