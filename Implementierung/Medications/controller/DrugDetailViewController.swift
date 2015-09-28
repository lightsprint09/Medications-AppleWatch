//
//  DrugDetailViewController.swift
//  Medications
//
//  Created by Lukas Schmidt on 15.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import UIKit

class DrugDetailViewController: UIViewController, DrugSettable {
    var drug:Drug!
    @IBOutlet weak var drugView: DrugCustomaziationView!
    @IBOutlet weak var drugNameLabel: UILabel!
    @IBOutlet weak var drugImageView: UIImageView!
    
    override func viewWillAppear(animated: Bool) {
        drugView.configureWithDrug(drug)
        drugNameLabel.text = drug.name
        title = drug.name
        drugImageView.image = drug.image
    }
}
