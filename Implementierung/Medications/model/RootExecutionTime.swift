//
//  RootExecutionTime.swift
//  Medications
//
//  Created by Lukas Schmidt on 30.09.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import Foundation
import CoreData

class RootExecutionTime: NSManagedObject {
    private static let dateFormatter = NSDateFormatter()
    var amountUnitString: String? {
        if let amountFloat = amount?.floatValue, let drugType = drug?.type {
            return "\(amountFloat) " + drugType.unit(amountFloat)
        }
        return nil
    }
    
    var timeOfDay: TimeOfDay {
        return TimeOfDay.timeOfDayFromDate(assignmentTime)
    }
    
    var timeString: String {
        RootExecutionTime.dateFormatter.dateFormat = "HH:mm"
        return RootExecutionTime.dateFormatter.stringFromDate(assignmentTime)
    }
}
