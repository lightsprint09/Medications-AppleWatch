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
    @IBOutlet weak var tableView: UITableView!
    
    func confirgureWithDaytimeMedication(daytime:DaytimeMedication) {
//        nameLabel.text = daytime.name
//        timeLabel.text = daytime.timeString
        
        let gradient = daytime.gradientColor
        gradient.frame = self.bounds
        layer.insertSublayer(gradient, atIndex: 0)
        layer.cornerRadius = 12
        layer.masksToBounds = true
    }
    
}