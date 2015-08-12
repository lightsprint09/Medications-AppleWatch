//
//  CoustomDrugViewController.swift
//  Medications
//
//  Created by Lukas Schmidt on 12.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import UIKit

class CoustomDrugViewController: UIViewController, UICollectionViewDelegate {
    @IBOutlet weak var drugView: DrugCustomaziationView!
    @IBOutlet weak var pillCollectionView: UICollectionView!
    
    var rgb:(Float, Float, Float) = (1,1,1) {
        didSet{
            drugView.pillBaseColor = rgbColor
        }
    }
    
    var rgbColor:UIColor {
        get {
            return sliderDelegate.getCurrentColor()
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
        let pillKind = DrugRenderEnum(rawValue: indexPath.row)
        drugView.drugKind = pillKind
    }
    
    let sliderDelegate = RGBColorSliderDelegate()
    
    @IBOutlet weak var redSlider: RGBColorSlider! {
        didSet {
            redSlider.connectAfterWithSliderColor(RGBColorTypeRed, trackHeight: 6, delegate: sliderDelegate)
        }
    }
    @IBOutlet weak var greenSlider: RGBColorSlider! {
        didSet {
            greenSlider.connectAfterWithSliderColor(RGBColorTypeGreen, trackHeight: 6, delegate: sliderDelegate)
        }
    }
    @IBOutlet weak var blueSlider: RGBColorSlider! {
        didSet {
            blueSlider.connectAfterWithSliderColor(RGBColorTypeBlue, trackHeight: 6, delegate: sliderDelegate)
        }
    }
}
