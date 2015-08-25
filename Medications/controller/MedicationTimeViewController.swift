//
//  MedicationTimeViewController.swift
//  Medications
//
//  Created by Lukas Schmidt on 25.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import UIKit
import CoreData

class MedicationTimeViewController: UIViewController {
    var medication: Medication!
    var executionTime: ExecutionTime!
    
    @IBOutlet weak var timePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        executionTime = medication.managedObjectContext!.insertObject() as ExecutionTime
    }

    @IBAction func dismissViewController(sender: AnyObject) {
        medication.managedObjectContext!.deleteObject(executionTime)
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func didChangeDaytime(sender: UISegmentedControl) {
        timePicker.setDate(NSDate(), animated: true)
    }

    @IBAction func timeDidChange(sender: UIDatePicker) {
        executionTime.assignmentDate = sender.date
    }
    @IBAction func done(sender: AnyObject) {
         presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
