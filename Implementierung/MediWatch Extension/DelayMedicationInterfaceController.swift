//
//  DelayMedication.swift
//  Medications
//
//  Created by Lukas Schmidt on 12.10.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import WatchKit

class DelayMedicationInterfaceController: WKInterfaceController, ExecutionTimesDisplayDetailsProtocol {
    @IBOutlet var drugImage: WKInterfaceImage!
    @IBOutlet var amountDrugLabel: WKInterfaceLabel!
    @IBOutlet var drugNameLabel: WKInterfaceLabel!
    
    var watchExecutionTimeContext: WatchExecutionTimeContext!
    
    var notification: UILocalNotification?
    
    override func awakeWithContext(context: AnyObject?) {
        
        WCSessionManager.sharedInstace.activate()
        if let notification = context as? UILocalNotification {
            self.notification = notification
            setupWithNotification(notification)
        }
        if let context = context as? WatchExecutionTimeContext{
            watchExecutionTimeContext = context
            displayExecutimeDetails(context.executionTime)
        }
    }
    
    func setupWithNotification(localNotification: UILocalNotification) {
        guard let executionTimeData = localNotification.userInfo as? [String: NSObject] else { return }
        let watchExecutionTimeService = WatchExecutionTimeService(sessionManager: WCSessionManager.sharedInstace)
        let executionTime = WatchExecutionTime(watchtData: executionTimeData)
        watchExecutionTimeContext = WatchExecutionTimeContext(executionTimeService: watchExecutionTimeService, executionTime: executionTime)
        //executionTimeInformation!["fireDate"] = localNotification.fireDate
        displayExecutimeDetails(executionTime)
    }
   
    @IBAction func moveFirstButtonClick() {
        delayExecutionTime(900)
    }
    
    @IBAction func moveSecondButtonClick() {
        delayExecutionTime(1800)
    }
    
    @IBAction func moveThirdButtonClick() {
        delayExecutionTime(3600)
    }
    
    @IBAction func moveFouthButtonClick() {
        delayExecutionTime(7200)
    }
    
    func delayExecutionTime(seconds: Int) {
//        guard let executionTimeInformation = executionTimeInformation else { return }
//        print(executionTimeInformation)
//        watchExecutionTimeContext.watchExecutionTimeService.delayExecutionTimeFromNotification(executionTimeInformation, delaySeconds: seconds)
        popController()
    }
}
