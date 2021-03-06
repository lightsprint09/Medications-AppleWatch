//
//  AddDrugViewController.swift
//  Medications
//
//  Created by Lukas Schmidt on 11.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import UIKit
import CoreData
import MobileCoreServices

class AddDrugViewController: UIViewController, ManagedObjectContextSettable, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var drugImageView: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var delteImageButton: UIButton!
    @IBOutlet weak var plusLabel: UILabel!
    @IBOutlet weak var addStructureButton: UIButton!
    
    var managedObjectContext:NSManagedObjectContext! {
        didSet {
            let context = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.MainQueueConcurrencyType)
            context.parentContext = managedObjectContext
            managedObjectContext = context
        }
    }
    
    weak var delegate: AddMedicationViewController?
    var drug:Drug!
    
    lazy var cameraUI = UIImagePickerController()
    
    override func viewDidLoad() {
        if drug == nil {
            drug = managedObjectContext.insertObject() as Drug
            drug.creationDate = NSDate()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        guard let pillImageData = drug.pillImage else { return }
        addStructureButton.titleLabel?.text = "Form ändern"
        plusLabel.hidden = true
        
        drugImageView.image = UIImage(data: pillImageData)
    }
    
    @IBAction func presentCamera(sender: AnyObject) {
        guard UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) else {return}
        cameraUI.delegate = self
        cameraUI.sourceType = UIImagePickerControllerSourceType.Camera;
        
        cameraUI.allowsEditing = true
        
        self.presentViewController(cameraUI, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker:UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        guard picker.sourceType == UIImagePickerControllerSourceType.Camera else { return }
        delteImageButton.hidden = false
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        drug.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func cancelDrugCreation(sender: AnyObject) {
        managedObjectContext.rollback()
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveDrug(sender: AnyObject) {
        managedObjectContext.saveOrRollback()
        delegate?.selectDrug(drug)
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func didChangeDrugName(sender: UITextField) {
        if let drugName = sender.text {
            drug.name = drugName
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destinationCV = (segue.destinationViewController as? UINavigationController)?.topViewController as? DrugSettable {
            var destinationCV = destinationCV
            destinationCV.drug = drug
        }
    }
}
