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
    let executionTimeService = ExecutionTimeService()
    
    var medication: Medication!
    var executionTime: ExecutionTime!
    var amount = 0.0 {
        didSet {
            executionTimeService.updateExecuitonTime(executionTime, assignmentDate: timePicker.date, amount: amount)
            doseTextField.text = "\(amount)"
            setupSegementedDoseControll()
        }
    }
    
    @IBOutlet weak var doseSegementedControl: UISegmentedControl!
    @IBOutlet weak var doseTextField: UITextField!
    @IBOutlet weak var timeOfDaySegmentedControl: UISegmentedControl!
    @IBOutlet weak var timePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let context = medication.managedObjectContext else { return }
        executionTime = executionTimeService.createExecutionTime(context, medication: medication, assignmentDate: timePicker.date)
        executionTime.isCreationTime = true
        setupSegementedDoseControll()
    }
    
    func setupSegementedDoseControll() {
        guard let drugType = medication.drug?.type else { return }
        doseSegementedControl.removeAllSegments()
        for unit in drugType.unitPreSets(Float(amount)).enumerate() {
            doseSegementedControl.insertSegmentWithTitle("\(unit.element) " + drugType.unit(unit.element), atIndex: unit.index, animated: false)
        }
    }

    @IBAction func dismissViewController(sender: AnyObject) {
        medication.managedObjectContext!.deleteObject(executionTime)
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func assignmentDateDidChange(sender: UIDatePicker) {
        let assignmentDate = sender.date
        executionTimeService.updateExecuitonTime(executionTime, assignmentDate: assignmentDate, amount: amount)
        
        timeOfDaySegmentedControl.selectedSegmentIndex = executionTime.timeOfDay.rawValue
        
    }
    @IBAction func done(sender: AnyObject) {
         presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func didChangeTimeOfDay(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex  != -1 {
            let timeOfDay = TimeOfDay(rawValue: sender.selectedSegmentIndex)
            let dateOfTime = timeOfDay!.startDate.dateByAddingTimeInterval(5400)
            timePicker.setDate(dateOfTime, animated: true)
            //TODO: This could be a bug. Change listener not called
            assignmentDateDidChange(timePicker)
        }
    }
    
    @IBAction func addOneDose(sender: AnyObject) {
        amount += 0.5
    }
    
    @IBAction func removeOneDose(sender: AnyObject) {
        guard (amount - 0.5) >= 0 else { return }
        amount -= 0.5
    }
}
