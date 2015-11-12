//
//  BigMedicationCell.swift
//  Medications
//
//  Created by Lukas Schmidt on 11.11.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import WatchKit

class BigMedicationCell: NSObject, ExecutionTimesDisplayDetailsProtocol {
    @IBOutlet var drugImage: WKInterfaceImage!
    @IBOutlet var drugNameLabel: WKInterfaceLabel!
    @IBOutlet var timeLabel: WKInterfaceLabel!
    @IBOutlet var amountDrugLabel: WKInterfaceLabel!
    @IBOutlet var markTakenImage: WKInterfaceImage!
    @IBOutlet var delayLabel: WKInterfaceLabel!
}
