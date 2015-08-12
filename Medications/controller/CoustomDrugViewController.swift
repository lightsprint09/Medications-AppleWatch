//
//  CoustomDrugViewController.swift
//  Medications
//
//  Created by Lukas Schmidt on 12.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import UIKit

class CoustomDrugViewController: UIViewController {
    @IBOutlet weak var drugView: DrugCustomaziationView!
    var rgb:(Float, Float, Float) = (0,0,0) {
        didSet{
            let color = UIColor(colorLiteralRed: rgb.0, green: rgb.1, blue: rgb.2, alpha: 1)
            drugView.pillBaseColor = color
        }
    }

    @IBAction func redChanged(sender: UISlider) {
        rgb.0 = sender.value
    }
    
    @IBAction func greenChanged(sender: UISlider) {
        rgb.1 = sender.value
    }
    
    @IBAction func blueChanged(sender: UISlider) {
        rgb.2 = sender.value
    }
    
}
