//
//  ExecutionTime.swift
//  Medications
//
//  Created by Lukas Schmidt on 10.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import Foundation
import CoreData

class ExecutionTime: NSManagedObject {
    private static let dateFormatter = NSDateFormatter()
    var timeOfDay: TimeOfDay {
        return TimeOfDay(rawValue: assignmentTimeOfDay.integerValue)!
    }
    
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
    
    var timeString: String {
        ExecutionTime.dateFormatter.dateFormat = "HH:mm"
        return ExecutionTime.dateFormatter.stringFromDate(assignmentDate)
    }
}
