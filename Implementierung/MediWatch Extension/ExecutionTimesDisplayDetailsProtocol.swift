//
//  ExecutionTimesDisplayDetailsProtocol.swift
//  Medications
//
//  Created by Lukas Schmidt on 23.10.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import WatchKit

protocol ExecutionTimesDisplayDetailsProtocol {
    var drugImage: WKInterfaceImage! { get }
    var amountDrugLabel: WKInterfaceLabel! { get }
    var drugNameLabel: WKInterfaceLabel! { get }
    
}

extension ExecutionTimesDisplayDetailsProtocol {
    func displayExecutimeDetails(executionTime: ExecutionTimeProtocol) {
        drugImage.setImageData(executionTime.drugImage)
        drugNameLabel.setText(executionTime.drugName)
        amountDrugLabel.setText(executionTime.amountUnitString)
        
    }
}
