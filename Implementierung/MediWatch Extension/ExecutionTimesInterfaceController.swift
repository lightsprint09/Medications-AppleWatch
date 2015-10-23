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

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        watchExecutionTimeService = WatchExecutionTimeService(sessionManager: WCSessionManager.sharedInstace, didDelayExecutionTime: nil)
        WCSessionManager.sharedInstace.activate()
        watchExecutionTimeService.getExecutionTimesOfToday({data in
            dispatch_async(dispatch_get_main_queue(), {
                self.executionTimesTable.setNumberOfRows(data.count, withRowType: "executionTimeCell2")
                for(index, executionTime) in data.enumerate() {
                    if let row = self.executionTimesTable.rowControllerAtIndex(index) as? ExecutionTimesCell{
                        row.drugLabel.setText(executionTime["drugName"] as? String)
                        row.timeLabel.setText(executionTime["timeString"] as? String)
                        row.drugImage.setImage(UIImage(data: executionTime["drugImageData"]! as! NSData))
                        
                    }
                }
            })
        })
        
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
