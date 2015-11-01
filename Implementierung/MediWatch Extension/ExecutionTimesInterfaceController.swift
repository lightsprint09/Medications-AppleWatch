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
        fetchExecutionTimes()
    }
    
    func fetchExecutionTimes() {
        if watchExecutionTimeService == nil {
            watchExecutionTimeService =  WatchExecutionTimeService(sessionManager: WCSessionManager.sharedInstace)
        }
        WCSessionManager.sharedInstace.activate()
        watchExecutionTimeService.fetchExecutionTimesOfToday(displayExecutionTimes)
    }
    
    func displayExecutionTimes(executionTimes:Array<WatchExecutionTimeContext>) {
        self.executionTimes = executionTimes
        self.executionTimesTable.setNumberOfRows(executionTimes.count, withRowType: "executionTimeCell2")
        for(index, executionTimeContext) in executionTimes.enumerate() {
            if let row = self.executionTimesTable.rowControllerAtIndex(index) as? ExecutionTimesCell{
                row.displayExecutimeDetails(executionTimeContext.executionTime)
                row.timeLabel.setText(executionTimeContext.executionTime.timeString)
                row.markTakenImage.setHidden(!executionTimeContext.executionTime.hasTakenMedication)
                row.timeLabel.setTextColor(executionTimeContext.executionTime.hasTakenMedication ? .greenExecutionTimeColor() : .blueExecutionTimeColor())
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
