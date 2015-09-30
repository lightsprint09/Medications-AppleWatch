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

class RepeatEventCreator: NSObject {
    func createEvent(startDate startDate: NSDate, endDate: NSDate, calculateNextDate: (NSDate)->NSDate, useDate: (NSDate)->(), finalCall:((NSDate)->())?) {
        useDate(startDate)
        var nextDate = startDate
        while endDate.compare(endDate) == .OrderedAscending {
            nextDate = calculateNextDate(nextDate)
            useDate(nextDate)
        }
        finalCall?(nextDate)
    }
}


