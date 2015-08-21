//
//  DaytimeCell.swift
//  Medications
//
//  Created by Lukas Schmidt on 20.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import UIKit

class DaytimeCell: UICollectionViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    func confirgureWithDaytimeMedication(daytime:DaytimeMedication) {
        nameLabel.text = daytime.name
        timeLabel.text = daytime.timeString
    }
   
}
