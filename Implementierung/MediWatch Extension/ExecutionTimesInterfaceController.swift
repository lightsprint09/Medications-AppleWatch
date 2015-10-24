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
    var executionTimes: NSArray!

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        watchExecutionTimeService = WatchExecutionTimeService(sessionManager: WCSessionManager.sharedInstace, didDelayExecutionTime: nil)
        WCSessionManager.sharedInstace.activate()
        watchExecutionTimeService.fetchExecutionTimesOfToday({executionTimes in
            self.executionTimes = executionTimes
            self.executionTimesTable.setNumberOfRows(executionTimes.count, withRowType: "executionTimeCell2")
            for(index, executionTime) in executionTimes.enumerate() {
                if let row = self.executionTimesTable.rowControllerAtIndex(index) as? ExecutionTimesCell{
                    row.displayExecutimeDetails(executionTime)
                    row.timeLabel.setText(executionTime["timeString"] as? String)
                    
                }
            }
        })

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