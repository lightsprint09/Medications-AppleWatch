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
    
    var watchExecutionTimeService: WatchExecutionTimeService!
    var executionTimeInformation: [String: AnyObject]!
    
    override func awakeWithContext(context: AnyObject?) {
        guard let executionTimeData = context as? [String: AnyObject] else { return }
        executionTimeInformation = executionTimeData
        displayExecutimeDetails(executionTimeData)
    }
    
    override func contextForSegueWithIdentifier(segueIdentifier: String) -> AnyObject? {
        return executionTimeInformation
    }
}
