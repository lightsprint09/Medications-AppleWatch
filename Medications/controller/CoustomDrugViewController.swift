//
//  CoustomDrugViewController.swift
//  Medications
//
//  Created by Lukas Schmidt on 12.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import UIKit

class CoustomDrugViewController: UIViewController, DrugSettable, UICollectionViewDelegate {
    @IBOutlet weak var drugView: DrugCustomaziationView!
    @IBOutlet weak var pillCollectionView: UICollectionView!
    var drug:Drug!
    
    var rgb:(Float, Float, Float) = (1,1,1) {
        didSet{
            drugView.pillBaseColor = rgbColor
            drug.color = rgbColor
        }
    }
    
    override func viewDidLoad() {
        drug.color = rgbColor
        guard let drugKind = drug.type, let color = drug.color else{ return }
        drugView.drugKind = drugKind
        drugView.pillBaseColor = color
        redSlider.setValue(Float(color.red()), animated: false)
        greenSlider.setValue(Float(color.green()), animated: false)
        blueSlider.setValue(Float(color.blue()), animated: false)
    }
    
    var rgbColor:UIColor {
        get {
            return sliderDelegate.getCurrentColor()
        }
    }
    
    @IBOutlet weak var redSlider: RGBColorSlider! {
        didSet {
            redSlider.connectAfterWithSliderColor(RGBColorTypeRed, trackHeight: 6, delegate: sliderDelegate)
            redSlider.setValue(1, animated: false)
        }
    }
    @IBOutlet weak var greenSlider: RGBColorSlider! {
        didSet {
            greenSlider.connectAfterWithSliderColor(RGBColorTypeGreen, trackHeight: 6, delegate: sliderDelegate)
            greenSlider.setValue(1, animated: false)
        }
    }
    @IBOutlet weak var blueSlider: RGBColorSlider! {
        didSet {
            blueSlider.connectAfterWithSliderColor(RGBColorTypeBlue, trackHeight: 6, delegate: sliderDelegate)
            blueSlider.setValue(1, animated: false)
        }
    }

    @IBAction func redChanged(sender: UISlider) {
        rgb.0 = 1 - sender.value
         pillCollectionView.reloadData()
    }
    
    @IBAction func greenChanged(sender: UISlider) {
        rgb.1 = 1 -  sender.value
         pillCollectionView.reloadData()
    }
    
    @IBAction func blueChanged(sender: UISlider) {
        rgb.2 = 1 -  sender.value
         pillCollectionView.reloadData()
    }
    
    @IBAction func finishDragging(sender: AnyObject) {
        pillCollectionView.reloadData()
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let pillKind = DrugEnum(rawValue: indexPath.row)
        drugView.drugKind = pillKind
        drug.type = pillKind
    }
    
    let sliderDelegate = RGBColorSliderDelegate()
    
    
}
