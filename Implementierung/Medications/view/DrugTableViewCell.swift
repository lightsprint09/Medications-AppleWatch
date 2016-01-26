//
//  DrugTableViewCell.swift
//  Medications
//
//  Created by Lukas Schmidt on 10.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import UIKit
import CoreDataStack

class DrugTableViewCell: UITableViewCell, ConfigurableCell {
    typealias DataSource = Drug
    
    @IBOutlet weak var drugImageView: UIImageView!
    @IBOutlet weak var drugNameLabel: UILabel!
    @IBOutlet weak var activeSubstanceLabel: UILabel!
    
    func configureForObject(drug: DataSource) {
        drugNameLabel.text = drug.name
        activeSubstanceLabel.text = drug.activeSubstance
        if let pillImageData = drug.pillImage {
            drugImageView.image = UIImage(data: pillImageData)
        }
    }
}
