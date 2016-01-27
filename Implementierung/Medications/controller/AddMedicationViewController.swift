//
//  AddMedicationViewController.swift
//  Medications
//
//  Created by Lukas Schmidt on 17.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import UIKit
import CoreData
import CoreDataStack

extension AddMedicationViewController: DataProviderDelegate, DataSourceDelegate {
    typealias Object = RootExecutionTime
    
    func dataProviderDidUpdate(updates: [DataProviderUpdate<Object>]?) {
        
    }
    
    func cellIdentifierForObject(object: Object) -> String {
        return "new-medication-cell"
    }
}

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
    var drugDataDelegate: DrugDataSourceDelegate!
    
    var drugDataProvider: FetchedResultsDataProvider<DrugDataSourceDelegate>!
    var drugCollectionViewDataSource: CollectionViewDataSource<DrugDataSourceDelegate, FetchedResultsDataProvider<DrugDataSourceDelegate>, AddDrugToMedicationCell>!
    
    var executionTimeDataProvider: FetchedResultsDataProvider<AddMedicationViewController>!
    var executionTimeDataSource: TableViewDataSource<AddMedicationViewController, FetchedResultsDataProvider<AddMedicationViewController>, ExecutionTimeTableViewCell>!
    
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
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext)
        drugDataDelegate =  DrugDataSourceDelegate()
        drugDataProvider = FetchedResultsDataProvider(fetchedResultsController: frc, delegate: drugDataDelegate)
        drugCollectionViewDataSource = CollectionViewDataSource(collectionView: collectionView, dataProvider: drugDataProvider, delegate: drugDataDelegate)
    }
    
    func setupExecutionTimeFetchController() {
        guard let drug = selectedDrug else { return }
        let fetchRequest = executionTimeService.rootExecutionTimeFetchRequest(drug)
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext)
        executionTimeDataProvider = FetchedResultsDataProvider(fetchedResultsController: frc, delegate: self)
        
        executionTimeDataSource = TableViewDataSource(tableView: executionTimeTableView, dataProvider: executionTimeDataProvider, delegate: self)
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
        let drug = drugDataProvider.objectAtIndexPath(indexPath)
        selectDrug(drug)
    }
    
    func selectDrug(drug: Drug) {
        guard let indexPath = drugDataProvider.indexPathForObject(drug) else { return }
        
        if let selectedDrug = selectedDrug, let currentlySelectedIndexPath = drugDataProvider.indexPathForObject(selectedDrug) {
            if let cell = collectionView.cellForItemAtIndexPath(currentlySelectedIndexPath) as? AddDrugToMedicationCell {
                cell.showSelectedBadge(false)
            }
        }
        selectedDrug = drugDataProvider.objectAtIndexPath(indexPath)
        if let cell = collectionView.cellForItemAtIndexPath(indexPath) as? AddDrugToMedicationCell {
            collectionView.selectItemAtIndexPath(indexPath, animated: false, scrollPosition: UICollectionViewScrollPosition.CenteredHorizontally)
            cell.showSelectedBadge(true)
            
        }
    }
    
    
    
    @IBAction func didChangeRepeatType(sender: UISegmentedControl) {
        UIView.animateWithDuration(0.4, delay: 0.0, usingSpringWithDamping: 1.0 , initialSpringVelocity: 0, options: [], animations: {self.weekDaySelectionView.hidden = sender.selectedSegmentIndex != 1}, completion: nil)
        
    }

}



