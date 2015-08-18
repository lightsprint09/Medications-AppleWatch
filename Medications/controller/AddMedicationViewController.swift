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
    
    @IBOutlet weak var collectionView: UICollectionView!
    
   
    
    override func viewDidLoad() {
        let frc = NSFetchedResultsController(fetchRequest: Drug.sortedFetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
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
    
   
}



