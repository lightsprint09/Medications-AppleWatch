//
//  WatchExecutionTime.swift
//  Medications
//
//  Created by Lukas Schmidt on 29.10.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import Foundation

class WatchExecutionTime: NSObject, ExecutionTimeProtocol {
    private static let dateFormatter = NSDateFormatter()
    
    var amount: NSDecimalNumber?
    var assignmentDate: NSDate
    var assignmentTimeOfDay: NSNumber
    var creationDate: NSDate
    var executionDate: NSDate?
    var secondsMoved: NSNumber?
    var notExecuted: NSNumber
    
    var timeString: String {
        WatchExecutionTime.dateFormatter.dateFormat = "HH:mm"
        return WatchExecutionTime.dateFormatter.stringFromDate(assignmentDate)
    }
    let amountUnitString: String?
    let drugName: String?
    let drugImage: NSData?
    
    private let iphoneData:[String: NSObject]
    
    var codingData: [String: NSObject] {
        var dict = iphoneData
        if let executionDate = executionDate {
            dict[notification_executionDateKey] = executionDate
        }
        if let secondsMoved = secondsMoved {
            dict[notification_secondsMovedKey] = secondsMoved
        }
        return dict
    }
    
    init(watchtData:[String: NSObject]) {
        iphoneData = watchtData
        assignmentDate = watchtData[notification_assignmentDateKey]! as! NSDate
        secondsMoved = watchtData[notification_secondsMovedKey] as? NSNumber
        assignmentTimeOfDay = 1
        executionDate = watchtData[notification_executionDateKey] as? NSDate
        creationDate = NSDate()
        notExecuted = false
        amountUnitString = watchtData[notification_drugAmountKey] as? String
        drugName = watchtData[notification_drugNameKey] as? String
        drugImage = watchtData[notification_drugImageDataKey] as? NSData
    }
}
