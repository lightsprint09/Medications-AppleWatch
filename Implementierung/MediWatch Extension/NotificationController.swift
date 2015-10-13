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

    
    override func didReceiveLocalNotification(localNotification: UILocalNotification, withCompletion completionHandler: ((WKUserNotificationInterfaceType) -> Void)) {
        
       setupWithNotification(localNotification)
        completionHandler(.Custom)
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
    
}
