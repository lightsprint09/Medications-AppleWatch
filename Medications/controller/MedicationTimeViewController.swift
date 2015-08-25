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
    @IBOutlet weak var doseSegementedControl: UISegmentedControl!
    @IBOutlet weak var doseTextField: UITextField!
    @IBOutlet weak var timeOfDaySegmentedControl: UISegmentedControl!
    var dose = 0.0 {
        didSet {
            executionTime.amount = NSNumber(double: dose)
            doseTextField.text = "\(dose)"
        }
    }
    
    @IBOutlet weak var timePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        executionTime = medication.managedObjectContext!.insertObject() as ExecutionTime
        executionTime.creationDate = NSDate()
        executionTime.assignmentDate = timePicker.date
    }

    @IBAction func dismissViewController(sender: AnyObject) {
        medication.managedObjectContext!.deleteObject(executionTime)
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func timeDidChange(sender: UIDatePicker) {
        let timeOfDay =  TimeOfDay.timeOfDayFromDate(sender.date)
        executionTime.assignmentDate = sender.date
        executionTime.assignmentTimeOfDay = NSNumber(integer:timeOfDay.rawValue)
        timeOfDaySegmentedControl.selectedSegmentIndex = timeOfDay.rawValue
        
    }
    @IBAction func done(sender: AnyObject) {
         presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func didChangeTimeOfDay(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex  != -1 {
            let timeOfDay = TimeOfDay(rawValue: sender.selectedSegmentIndex)
            timePicker.setDate(timeOfDay!.startDate.dateByAddingTimeInterval(5400), animated: true)
            //TODO: This could be a bug. Change listener not called
            timeDidChange(timePicker)
        }
    }
    
    @IBAction func addOneDose(sender: AnyObject) {
        dose += 0.5
    }
    
    @IBAction func removeOneDose(sender: AnyObject) {
        guard (dose - 0.5) >= 0 else {return}
        dose -= 0.5
    }
}
