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
    
    var watchExecutionTimeService: WatchExecutionTimeService!
    
    var notification: UILocalNotification?
    var executionTimeInformation: [String: AnyObject]?
    
    override func awakeWithContext(context: AnyObject?) {
        watchExecutionTimeService = WatchExecutionTimeService(sessionManager: WCSessionManager.sharedInstace)
        WCSessionManager.sharedInstace.activate()
        if let notification = context as? UILocalNotification {
            self.notification = notification
            setupWithNotification(notification)
        }
        if let executionTimeData = context as? [String: AnyObject] {
            executionTimeInformation = executionTimeData
            displayExecutimeDetails(executionTimeData)
        }
    }
    
    func setupWithNotification(localNotification: UILocalNotification) {
        guard let executionTimeData = localNotification.userInfo as? [String: AnyObject] else { return }
        executionTimeInformation = executionTimeData
        executionTimeInformation!["fireDate"] = localNotification.fireDate
        displayExecutimeDetails(executionTimeData)
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
        guard let executionTimeInformation = executionTimeInformation else { return }
        print(executionTimeInformation)
        watchExecutionTimeService.delayExecutionTimeFromNotification(executionTimeInformation, delaySeconds: seconds)
        popController()
    }
}
