//
//  WatchExecutionTime.swift
//  Medications
//
//  Created by Lukas Schmidt on 29.10.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import Foundation

class WatchExecutionTime: NSObject, ExecutionTimeProtocol {
    var amount: NSDecimalNumber?
    var assignmentDate: NSDate
    var assignmentTimeOfDay: NSNumber
    var creationDate: NSDate
    var executionDate: NSDate?
    var secondsMoved: NSNumber?
    var notExecuted: NSNumber
    
    let timeString: String
    let amountUnitString: String?
    let drugName: String?
    let drugImage: NSData?
    
    init(watchtData:[String: NSObject]) {
        assignmentDate = watchtData["fireDate"]! as! NSDate
        secondsMoved = watchtData["secondsMoved"] as? NSNumber
        assignmentTimeOfDay = 1
        creationDate = NSDate()
        notExecuted = false
        timeString = watchtData["timeString"] as! String
        amountUnitString = watchtData[notification_drugAmountKey] as? String
        drugName = watchtData[notification_drugNameKey] as? String
        drugImage = watchtData[notification_drugImageDataKey] as? NSData
    }
    
   
}
