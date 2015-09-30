//
//  MedicationTimeViewController.swift
//  Medications
//
//  Created by Lukas Schmidt on 25.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import UIKit
import CoreData

class CreateRootExecutionTimeViewController: UIViewController {
    let executionTimeService = ExecutionTimeService()
    var drug: Drug!
    
    var executionTime: RootExecutionTime!
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
        guard let managedObjectContext = drug.managedObjectContext else { return }
        executionTime = executionTimeService.createRootExecutionTime(managedObjectContext, assignmentDate: timePicker.date)
        executionTime.drug = drug
        setupSegementedDoseControll()
    }
    
    func setupSegementedDoseControll() {
        guard let drugType = executionTime.drug?.type else { return }
        doseSegementedControl.removeAllSegments()
        for unit in drugType.unitPreSets(Float(amount)).enumerate() {
            doseSegementedControl.insertSegmentWithTitle("\(unit.element) " + drugType.unit(unit.element), atIndex: unit.index, animated: false)
        }
    }

    @IBAction func dismissViewController(sender: AnyObject) {
        drug.managedObjectContext?.deleteObject(executionTime)
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func assignmentDateDidChange(sender: UIDatePicker) {
        let assignmentDate = sender.date
        executionTimeService.updateExecuitonTime(executionTime, assignmentDate: assignmentDate, amount: amount)
        let timeOfDay = TimeOfDay.timeOfDayFromDate(assignmentDate)
        timeOfDaySegmentedControl.selectedSegmentIndex = timeOfDay.rawValue
        
    }
    @IBAction func done(sender: AnyObject) {
        executionTimeService.createChildExecutionTimeFromParent(executionTime, startDate: timePicker.date, endDate: NSDate().dateByAddingTimeInterval(604.800))
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
