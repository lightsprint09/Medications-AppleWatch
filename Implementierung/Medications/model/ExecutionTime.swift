//
//  ExecutionTime.swift
//  Medications
//
//  Created by Lukas Schmidt on 10.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import Foundation
import CoreData

class ExecutionTime: NSManagedObject, ExecutionTimeProtocol {
    private static let dateFormatter = NSDateFormatter()
    
    var amountUnitString: String? {
        let formatter = NSNumberFormatter()
        formatter.maximumFractionDigits = 2
        if let amountFloat = amount?.floatValue,
            let amountString = formatter.stringFromNumber(amountFloat),
            let drugType = parentExecutionTime.drug?.type {
            return "\(amountString) " + drugType.unit(amountFloat)
        }
        return nil
    }
    
    //TODO refactor
    var timeString: String {
        return ExecutionTime.timeStrintFromDate(assignmentDate)
    }
    
    var drugName: String? {
        return parentExecutionTime.drug?.name
    }
    
    var drugImage: NSData? {
        return parentExecutionTime.drug?.pillImage
    }
    
    static func timeStrintFromDate(date:NSDate) -> String {
        ExecutionTime.dateFormatter.dateFormat = "HH:mm"
        return ExecutionTime.dateFormatter.stringFromDate(date)
    }
    
    var codingData: [String: NSObject] {
        var dict = [notification_assignmentDateKey: assignmentDate, notification_coreDataIDKey: parentExecutionTime.objectID.URIRepresentation().absoluteString]
        if let drugName = drugName {
            dict[notification_drugNameKey] = drugName
        }
        if let drugImage = drugImage {
            dict[notification_drugImageDataKey] = drugImage
        }
        if let amountUnitString = amountUnitString {
            dict[notification_drugAmountKey] = amountUnitString
        }
        
        if let executionDate = executionDate {
            dict[notification_executionDateKey] = executionDate
        }
        return dict
    }
    
    func updateWithCodingData(codingData: [String: NSObject]) {
        self.executionDate = codingData[notification_executionDateKey] as? NSDate
        self.secondsMoved = codingData[notification_secondsMovedKey] as? NSNumber
    }
    
}
