//
//  InterfaceController.swift
//  MediWatch Extension
//
//  Created by Lukas Schmidt on 17.07.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import WatchKit
import Foundation


class ExecutionTimesInterfaceController: WKInterfaceController {
    
    @IBOutlet var executionTimesTable: WKInterfaceTable!
    var watchExecutionTimeService: WatchExecutionTimeService!
    var executionTimes: Array<WatchExecutionTimeContext>!

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        fetchExecutionTimes()
    }
    
    override func willActivate() {
        if(executionTimes != nil) {
            displayExecutionTimes()
        }
        fetchExecutionTimes()
    }
    
    func fetchExecutionTimes() {
        if watchExecutionTimeService == nil {
            watchExecutionTimeService =  WatchExecutionTimeService(sessionManager: WCSessionManager.sharedInstace)
        }
        WCSessionManager.sharedInstace.activate()
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            self.watchExecutionTimeService.fetchExecutionTimesOfToday(self.didFetchExecutionTimes)
        })
        
    }
    
    func didFetchExecutionTimes(executionTimes:Array<WatchExecutionTimeContext>) {
        self.executionTimes = executionTimes
        displayExecutionTimes()
    }
    
    func displayExecutionTimes() {
        self.executionTimesTable.setNumberOfRows(executionTimes.count, withRowType: "executionTimeCell")
        for(index, executionTimeContext) in executionTimes.enumerate() {
            if let row = self.executionTimesTable.rowControllerAtIndex(index) as? ExecutionTimesCell {
                let executionTime = executionTimeContext.executionTime
                row.displayExecutimeDetails(executionTime)
                row.timeLabel.setText(executionTime.timeString)
                row.markTakenImage.setHidden(!executionTime.hasTakenMedication)
                row.timeLabel.setTextColor(executionTime.hasTakenMedication ? .greenExecutionTimeColor() : .blueExecutionTimeColor())
            }
        }
    }
    
    override func contextForSegueWithIdentifier(segueIdentifier: String, inTable table: WKInterfaceTable, rowIndex: Int) -> AnyObject? {
        return executionTimes[rowIndex]
    }
    
    override func handleActionWithIdentifier(identifier: String?, forLocalNotification localNotification: UILocalNotification) {
        guard let identifier = identifier else { return }
        switch identifier {
        case takeMedicationNotificationActionIdentifier:
            break
        case delayMedicationNotificationActionIdentifier:
            presentControllerWithName("delay_medication_controller", context: localNotification)
            break
        default:
            break
        }
    }

}
