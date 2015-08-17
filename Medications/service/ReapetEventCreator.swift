//
//  ReapetEventCreator.swift
//  Medications
//
//  Created by Lukas Schmidt on 16.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import Foundation

enum RepeatType {
    case Daily, Weekly, Monthly
}

class ReapetEventCreator: NSObject {
    func createEvent(startDate startDate:NSDate, repeatCount:Int, calculateNextDate:(NSDate)->NSDate, useDate:(NSDate)->(),  finalCall:(NSDate)->()) {
        useDate(startDate)
        var nextDate = startDate
        for var i = 0; i < repeatCount; i++ {
            nextDate = calculateNextDate(nextDate)
            useDate(nextDate)
        }
        finalCall(nextDate)
    }
}
