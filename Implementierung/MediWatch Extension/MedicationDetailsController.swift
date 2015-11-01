//
//  MedicationDetailsController.swift
//  Medications
//
//  Created by Lukas Schmidt on 23.10.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import WatchKit

class MedicationDetailsController: WKInterfaceController, ExecutionTimesDisplayDetailsProtocol {
    @IBOutlet var drugImage: WKInterfaceImage!
    @IBOutlet var amountDrugLabel: WKInterfaceLabel!
    @IBOutlet var drugNameLabel: WKInterfaceLabel!
    @IBOutlet var checkTakenImage: WKInterfaceImage!
    @IBOutlet var delayTimeLabel: WKInterfaceLabel!
    
    var executionTimeContext: WatchExecutionTimeContext!
    
    override func awakeWithContext(context: AnyObject?) {
        guard let context = context as? WatchExecutionTimeContext else { return }
        executionTimeContext = context
        displayExecutimeDetails(context.executionTime)
        
    }
    
    override func willActivate() {
        checkTakenImage.setHidden(executionTimeContext.executionTime.executionDate == nil)
        if let delayTime = executionTimeContext.executionTime.secondsMoved {
            delayTimeLabel.setText("+\(delayTime.intValue / 60)")
        }
    }
    
    @IBAction func onTakeMedication() {
        let executionTimeService = executionTimeContext.executionTimeService
        executionTimeService.executeExecutionTimeWithNotification(executionTimeContext.executionTime)
        executionTimeContext.executionTime.executionDate = NSDate()
        checkTakenImage.setHidden(false)
        self.checkTakenImage.setWidth(5)
        self.checkTakenImage.setHeight(5)
        animateWithDuration(0.3, animations: {
            self.checkTakenImage.setWidth(26)
            self.checkTakenImage.setHeight(26)
        })
       
    }
    
    override func contextForSegueWithIdentifier(segueIdentifier: String) -> AnyObject? {
        return executionTimeContext
    }
}
