//
//  RootExecutionTime.swift
//  Medications
//
//  Created by Lukas Schmidt on 30.09.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class RootExecutionTime: NSManagedObject {
    private static let dateFormatter = NSDateFormatter()
    var amountUnitString: String? {
        let formatter = NSNumberFormatter()
        formatter.maximumFractionDigits = 2
        if let amountFloat = amount?.floatValue,
            let amountString = formatter.stringFromNumber(amountFloat),
            let drugType = drug?.type {
                return "\(amountString) " + drugType.unit(amountFloat)
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
    
    override func prepareForDeletion() {
        let executionTimeService = ExecutionTimeService()
        guard let notification = executionTimeService.notificationForExecutionTime(self) else { return }
        //TODO remove UIKit From model
        UIApplication.sharedApplication().cancelLocalNotification(notification)
    }
}
