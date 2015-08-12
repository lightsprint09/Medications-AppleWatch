//
//  AddDrugViewController.swift
//  Medications
//
//  Created by Lukas Schmidt on 11.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import UIKit
import CoreData

class AddDrugViewController: UIViewController, ManagedObjectContextSettable {
    
    var managedObjectContext:NSManagedObjectContext!
    var drug:Drug!
    
    override func viewDidLoad() {
        if drug == nil {
            drug = managedObjectContext.insertObject() as Drug
            drug.creationDate = NSDate()
        }
    }

    @IBAction func cancelDrugCreation(sender: AnyObject) {
        managedObjectContext.rollback()
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveDrug(sender: AnyObject) {
        managedObjectContext.saveOrRollback()
         presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func didChangeDrugName(sender: UITextField) {
        if let drugName = sender.text {
            drug.name = drugName
        }
    }
}
