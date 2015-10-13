//
//  DelayMedication.swift
//  Medications
//
//  Created by Lukas Schmidt on 12.10.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import WatchKit

class DelayMedicationInterfaceController: WKInterfaceController {
    @IBOutlet var drugImage: WKInterfaceImage!
    
    @IBOutlet var amountDrugLabel: WKInterfaceLabel!
    @IBOutlet var drugNameLabel: WKInterfaceLabel!
    
    var notification: UILocalNotification?
    
    override func awakeWithContext(context: AnyObject?) {
        if let notification = context as? UILocalNotification {
            setupWithNotification(notification)
        }
    }
    
    func setupWithNotification(localNotification: UILocalNotification) {
        if let imageData = localNotification.userInfo?[notification_drugImageDataKey] as? NSData {
            let image = UIImage(data: imageData)
            self.drugImage.setImage(image)
        }
        
        if let drugName = localNotification.userInfo?[notification_drugNameKey] as? String {
            drugNameLabel.setText(drugName)
        }
        if let drugAmount = localNotification.userInfo?[notification_drugAmountKey] as? String {
            amountDrugLabel.setText(drugAmount)
        }
        
    }
   
    @IBAction func moveFirstButtonClick() {
        
    }
    
    @IBAction func moveSecondButtonClick() {
        
    }
    
    @IBAction func moveThirdButtonClick() {
        
    }
    
    @IBAction func moveFouthButtonClick() {
        
    }
    
    
    
    
    
}
