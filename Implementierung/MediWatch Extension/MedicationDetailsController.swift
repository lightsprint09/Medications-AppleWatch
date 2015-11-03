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
    @IBOutlet var takeMedicationButton: WKInterfaceButton!
    @IBOutlet var delayMedicationButton: WKInterfaceButton!
    
    var executionTimeContext: WatchExecutionTimeContext!
    var executionTime: ExecutionTimeProtocol {
        return executionTimeContext.executionTime
    }
    
    override func awakeWithContext(context: AnyObject?) {
        guard let context = context as? WatchExecutionTimeContext else { return }
        executionTimeContext = context
        displayExecutimeDetails(context.executionTime)
        
    }
    
    override func willActivate() {
        updateUI()
    }
    
    @IBAction func onTakeMedication() {
        executionTime.executionDate = executionTime.hasTakenMedication ? nil : NSDate()
        let executionTimeService = executionTimeContext.executionTimeService
        executionTimeService.updateExecutionTime(executionTime)
        updateUI()
        animateTakenIcon()
    }
    
    func updateUI() {
        checkTakenImage.setHidden(!executionTime.hasTakenMedication)
        takeMedicationButton.setTitle(executionTime.hasTakenMedication ? "Nicht genommen" : "Nehmen")
        delayMedicationButton.setEnabled(!executionTime.hasTakenMedication)
        if let delayTime = executionTime.secondsMoved {
            delayTimeLabel.setText("+\(delayTime.intValue / 60)")
        }
    }
    
    func animateTakenIcon() {
        self.checkTakenImage.setWidth(5)
        self.checkTakenImage.setHeight(5)
        animateWithDuration(0.3, animations: {
            self.checkTakenImage.setWidth(26)
            self.checkTakenImage.setHeight(26)
        })
    }
    
    @IBAction func notTakenMedication() {
    }
    
    override func contextForSegueWithIdentifier(segueIdentifier: String) -> AnyObject? {
        return executionTimeContext
    }
}
