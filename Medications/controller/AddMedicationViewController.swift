//
//  AddMedicationViewController.swift
//  Medications
//
//  Created by Lukas Schmidt on 17.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import UIKit
import CoreData

class AddMedicationViewController: UIViewController, ManagedObjectContextSettable, UICollectionViewDelegate {
    var managedObjectContext: NSManagedObjectContext!
    var dataSource: FetchedResultsCollectionViewController<AddMedicationViewController>?
    let drugService = DrugDBService()
    var repeatEventCreator = RepeatEventCreator()
    
    @IBOutlet weak var weekDaySelectionView: UIStackView!
    var selectedDrug:Drug?
    
    let daytimeDataSource = DayTimeSource()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        let frc = NSFetchedResultsController(fetchRequest: drugService.sortedFetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        dataSource = FetchedResultsCollectionViewController(collectionView: collectionView, fetchedResultsController: frc, delegate: self)
    }
    
    @IBAction func cancelAddMedication(sender: AnyObject) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let managedObjectContextSettable = segue.destinationViewController as? ManagedObjectContextSettable {
            var managedObjectContextSettable = managedObjectContextSettable
            managedObjectContextSettable.managedObjectContext = managedObjectContext
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let selectedDrug = selectedDrug, let currentlySelectedIndexPath = dataSource?.fetchedResultsController.indexPathForObject(selectedDrug) {
            if let cell = collectionView.cellForItemAtIndexPath(currentlySelectedIndexPath) as? AddDrugToMedicationCell {
                cell.showSelectedBadge(false)
            }
        }
        selectedDrug = dataSource?.objectAtIndexPath(indexPath)
        if let cell = collectionView.cellForItemAtIndexPath(indexPath) as? AddDrugToMedicationCell {
            cell.showSelectedBadge(true)
        }
        
    }
    
    @IBAction func didChangeRepeatType(sender: UISegmentedControl) {
        UIView.animateWithDuration(0.4, delay: 0.0, usingSpringWithDamping: 1.0 , initialSpringVelocity: 0, options: [], animations: {self.weekDaySelectionView.hidden = sender.selectedSegmentIndex != 1}, completion: nil)
        
    }
    
    func createMedication() {
        let medication: Medication = managedObjectContext.insertObject()
        medication.drug = selectedDrug
        repeatEventCreator.createEvent(startDate: NSDate(), repeatCount: 2 * 7, calculateNextDate: {date in  date}, useDate: {date in
            let executionTime: ExecutionTime = self.managedObjectContext.insertObject()
            executionTime.creationDate = NSDate()
            executionTime.assignmentDate = date
//            executionTime.medication
            }, finalCall: {date in})
    }
   
}



