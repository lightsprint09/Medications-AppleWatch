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
    
    let drugService = DrugDBService()
    let repeatEventCreator = RepeatEventCreator()
    let executionTimeService = ExecutionTimeService()
    
    var selectedDrug:Drug?{
        didSet {
            setupExecutionTimeFetchController()
            repeatSegementedControl.enabled = true
            addExecutionTimeButton.enabled = true
            removeExecutionTimeButton.enabled = true
        }
    }
    
    var drugDataSource: FetchedResultsCollectionViewController<AddMedicationViewController>?
    var executionTimeDataSource: FetchedResultsDataSource<ExecutionTimeTableViewDataSourceDelegate>?
    let executionTimeDataSourceDelegate = ExecutionTimeTableViewDataSourceDelegate()
    
    @IBOutlet weak var weekDaySelectionView: UIStackView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var executionTimeTableView: UITableView!
    @IBOutlet weak var repeatSegementedControl: UISegmentedControl!
    @IBOutlet weak var addExecutionTimeButton: UIButton!
    @IBOutlet weak var removeExecutionTimeButton: UIButton!
    
    override func viewDidLoad() {
        setupDrugFetchController()
    }
    
    func setupDrugFetchController() {
        let fetchRequest = drugService.sortedFetchRequest()
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        drugDataSource = FetchedResultsCollectionViewController(collectionView: collectionView, fetchedResultsController: frc, delegate: self)
    }
    
    func setupExecutionTimeFetchController() {
        guard let drug = selectedDrug else { return }
        let fetchRequest = executionTimeService.rootExecutionTimeFetchRequest(drug)
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
        if let medicationTimeController = (segue.destinationViewController as? UINavigationController)?.topViewController as? CreateRootExecutionTimeViewController {
            medicationTimeController.drug = selectedDrug
        }
        if let createDrugController = (segue.destinationViewController as? UINavigationController)?.topViewController as? AddDrugViewController {
            createDrugController.delegate = self
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        guard let drug = drugDataSource?.objectAtIndexPath(indexPath) else { return }
        selectDrug(drug)
    }
    
    func selectDrug(drug: Drug) {
        guard let indexPath = drugDataSource?.fetchedResultsController.indexPathForObject(drug) else { return }
        
        if let selectedDrug = selectedDrug, let currentlySelectedIndexPath = drugDataSource?.fetchedResultsController.indexPathForObject(selectedDrug) {
            if let cell = collectionView.cellForItemAtIndexPath(currentlySelectedIndexPath) as? AddDrugToMedicationCell {
                cell.showSelectedBadge(false)
            }
        }
        selectedDrug = drugDataSource?.objectAtIndexPath(indexPath)
        if let cell = collectionView.cellForItemAtIndexPath(indexPath) as? AddDrugToMedicationCell {
            collectionView.selectItemAtIndexPath(indexPath, animated: false, scrollPosition: UICollectionViewScrollPosition.CenteredHorizontally)
            cell.showSelectedBadge(true)
            
        }
    }
    
    
    
    @IBAction func didChangeRepeatType(sender: UISegmentedControl) {
        UIView.animateWithDuration(0.4, delay: 0.0, usingSpringWithDamping: 1.0 , initialSpringVelocity: 0, options: [], animations: {self.weekDaySelectionView.hidden = sender.selectedSegmentIndex != 1}, completion: nil)
        
    }

}



