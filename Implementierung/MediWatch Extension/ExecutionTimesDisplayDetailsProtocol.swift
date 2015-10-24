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
    func displayExecutimeDetails(executionTimeData: [String: AnyObject]) {
        if let imageData = executionTimeData[notification_drugImageDataKey] as? NSData {
            let image = UIImage(data: imageData)
            self.drugImage.setImage(image)
        }
        
        if let drugName = executionTimeData[notification_drugNameKey] as? String {
            drugNameLabel.setText(drugName)
        }
        if let drugAmount = executionTimeData[notification_drugAmountKey] as? String {
            amountDrugLabel.setText(drugAmount)
        }
        
        if let drugAmount = executionTimeData[notification_drugAmountKey] as? String {
            amountDrugLabel.setText(drugAmount)
        }
    }
}
