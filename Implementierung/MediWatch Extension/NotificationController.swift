//
//  NotificationController.swift
//  MediWatch Extension
//
//  Created by Lukas Schmidt on 17.07.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import WatchKit
import Foundation


class NotificationController: WKUserNotificationInterfaceController, ExecutionTimesDisplayDetailsProtocol {
    @IBOutlet var drugImage: WKInterfaceImage!
    @IBOutlet var amountDrugLabel: WKInterfaceLabel!
    @IBOutlet var drugNameLabel: WKInterfaceLabel!

    
    override func didReceiveLocalNotification(localNotification: UILocalNotification, withCompletion completionHandler: ((WKUserNotificationInterfaceType) -> Void)) {
        
       setupWithNotification(localNotification)
        completionHandler(.Custom)
    }
    
    func setupWithNotification(localNotification: UILocalNotification) {
        localNotification.userInfo?["fireDate"] = localNotification.fireDate
        guard let executionTimeData = localNotification.userInfo as? [String: NSObject] else { return }
        let executionTime = WatchExecutionTime(watchtData: executionTimeData)
        displayExecutimeDetails(executionTime)
    }
}
