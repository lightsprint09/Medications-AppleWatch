//
//  ExecutionTimesCell.swift
//  Medications
//
//  Created by Lukas Schmidt on 14.10.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import WatchKit

class ExecutionTimesCell: NSObject, ExecutionTimesDisplayDetailsProtocol {
    @IBOutlet var drugImage: WKInterfaceImage!
    @IBOutlet var drugNameLabel: WKInterfaceLabel!
    @IBOutlet var timeLabel: WKInterfaceLabel!
    @IBOutlet var amountDrugLabel: WKInterfaceLabel!
}
