//
//  NotificationController.swift
//  MediWatch Extension
//
//  Created by Lukas Schmidt on 17.07.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import WatchKit
import Foundation


class NotificationController: WKUserNotificationInterfaceController {
    @IBOutlet var drugImage: WKInterfaceImage!

    @IBOutlet var amountDrugLabel: WKInterfaceLabel!
    @IBOutlet var drugNameLabel: WKInterfaceLabel!
    override init() {
        // Initialize variables here.
        super.init()
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    
    override func didReceiveLocalNotification(localNotification: UILocalNotification, withCompletion completionHandler: ((WKUserNotificationInterfaceType) -> Void)) {
        
        displayDrugNameSync(localNotification)
        
        if let drugName = localNotification.userInfo?[notification_drugNameKey] as? String {
            drugNameLabel.setText(drugName)
        }
        if let drugAmount = localNotification.userInfo?[notification_drugAmountKey] as? String {
            amountDrugLabel.setText(drugAmount)
        }
        
        completionHandler(.Custom)
    }
    
    func displayDrugNameAsync(localNotification: UILocalNotification) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            if let imageData = localNotification.userInfo?[notification_drugImageDataKey] as? NSData {
                let image = UIImage(data: imageData)
                dispatch_async(dispatch_get_main_queue(), {
                    self.drugImage.setImage(image)
                })
            }
        })
    }
    
    func displayDrugNameSync(localNotification: UILocalNotification) {
        if let imageData = localNotification.userInfo?[notification_drugImageDataKey] as? NSData {
            let image = UIImage(data: imageData)
            self.drugImage.setImage(image)
        }
    }
    
}
