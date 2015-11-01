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
    
    var watchExecutionTimeContext: WatchExecutionTimeContext!
    
    override func awakeWithContext(context: AnyObject?) {
        guard let context = context as? WatchExecutionTimeContext else { return }
        watchExecutionTimeContext = context
        
        displayExecutimeDetails(context.executionTime)
    }
    
    @IBAction func onTakeMedication() {
       //watchExecutionTimeService.executeExecutionTimeWithNotification(executionTimeInformation)
    }
    
    override func contextForSegueWithIdentifier(segueIdentifier: String) -> AnyObject? {
        return watchExecutionTimeContext
    }
}
