//
//  AddMedicationViewController.swift
//  Medications
//
//  Created by Lukas Schmidt on 17.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import UIKit
import CoreData

class AddMedicationViewController: UIViewController, ManagedObjectContextSettable, UICollectionViewDelegate, UITableViewDelegate {
    var managedObjectContext: NSManagedObjectContext!
    var drugDataSource: FetchedResultsCollectionViewController<AddMedicationViewController>?
    var executionTimeDataSource: FetchedResultsDataSource<ExecutionTimeTableViewDataSourceDelegate>?
    let drugService = DrugDBService()
    var repeatEventCreator = RepeatEventCreator()
    var medication: Medication!
    let executionTimeDataSourceDelegate = ExecutionTimeTableViewDataSourceDelegate()
    
    
    @IBOutlet weak var weekDaySelectionView: UIStackView!
    var selectedDrug:Drug?{
        didSet {
            createMedicationFetch()
            medication.drug = selectedDrug
        }
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var executionTimeTableView: UITableView!
    
    override func viewDidLoad() {
        medication = managedObjectContext.insertObject() as Medication
        let frc = NSFetchedResultsController(fetchRequest: drugService.sortedFetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        drugDataSource = FetchedResultsCollectionViewController(collectionView: collectionView, fetchedResultsController: frc, delegate: self)
        
    }
    
    
    func createMedicationFetch() {
        let fetchRequest = NSFetchRequest(entityName: ExecutionTime.entityName)
        let sortDiscriptor = NSSortDescriptor(key: "assignmentDate", ascending: true)
        fetchRequest.sortDescriptors = [sortDiscriptor]
        fetchRequest.predicate = NSPredicate(format: "medication == %@", medication)
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        executionTimeDataSource = FetchedResultsDataSource(tableView: executionTimeTableView, fetchedResultsController: frc, delegate: executionTimeDataSourceDelegate)
        
    }
   
    @IBAction func toggleDeleteInTableView(sender: AnyObject) {
        executionTimeTableView.setEditing(!executionTimeTableView.editing, animated: true)
    }
    @IBAction func saveMedication(sender: AnyObject) {
        managedObjectContext.saveOrRollback()
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancelAddMedication(sender: AnyObject) {
        managedObjectContext.rollback()
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let managedObjectContextSettable = segue.destinationViewController as? ManagedObjectContextSettable {
            var managedObjectContextSettable = managedObjectContextSettable
            managedObjectContextSettable.managedObjectContext = managedObjectContext
        }
        if let medicationTimeController = (segue.destinationViewController as? UINavigationController)?.topViewController as? MedicationTimeViewController {
            medicationTimeController.medication = medication
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let selectedDrug = selectedDrug, let currentlySelectedIndexPath = drugDataSource?.fetchedResultsController.indexPathForObject(selectedDrug) {
            if let cell = collectionView.cellForItemAtIndexPath(currentlySelectedIndexPath) as? AddDrugToMedicationCell {
                cell.showSelectedBadge(false)
            }
        }
        selectedDrug = drugDataSource?.objectAtIndexPath(indexPath)
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
    }
}



