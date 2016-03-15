//
//  CoustomDrugViewController.swift
//  Medications
//
//  Created by Lukas Schmidt on 12.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import UIKit
import CoreDataStack

class CoustomizeDrugViewController: UIViewController, UICollectionViewDelegate, ManagedObjectDisplaying {
    typealias Displayable = Drug
    var displayingObject: Drug!
    var observer: GenericObserver<Drug>!
    
    func didChangeObject(changeType: ManagedObjectObserver.ChangeType, object drug: Drug) {
        let color = drug.color!
        drugView.pillBaseColor = color
        redSlider.setValue(Float(color.red()), animated: false)
        greenSlider.setValue(Float(color.green()), animated: false)
        blueSlider.setValue(Float(color.blue()), animated: false)
        pillCollectionView.reloadData()
        guard let drugKind = drug.type else{
            return }
        drugView.drugKind = drugKind
    }
    
    
    @IBOutlet weak var drugView: DrugCustomaziationView!
    @IBOutlet weak var pillCollectionView: UICollectionView!

    let sliderDelegate = RGBColorSliderDelegate()
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        displayingObject.color = displayingObject.color ?? .whiteColor()
        observer = GenericObserver(object: displayingObject, changeHandler: didChangeObject)
    }
    
    override func viewWillDisappear(animated: Bool) {
      observer = nil
    }
    
    @IBAction func doneViewController(sender: AnyObject) {
        if let color = displayingObject.color, let renderesPill = displayingObject.type?.renderToImage(CGSize(width: 90, height: 90), baseColor: color) {
             displayingObject.pillImage = UIImagePNGRepresentation(renderesPill)
        }
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
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
        displayingObject.color = sliderDelegate.getCurrentColor()
    }
    
    @IBAction func greenChanged(sender: UISlider) {
        displayingObject.color = sliderDelegate.getCurrentColor()
    }
    
    @IBAction func blueChanged(sender: UISlider) {
        displayingObject.color = sliderDelegate.getCurrentColor()
    }
    
    @IBAction func finishDragging(sender: AnyObject) {
        pillCollectionView.reloadData()
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let pillKind = DrugEnum(rawValue: indexPath.row)
        displayingObject.type = pillKind
    }
    
    
    
    
}
