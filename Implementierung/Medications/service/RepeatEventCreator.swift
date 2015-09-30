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
    
    var calculateNextDate: (NSDate) -> NSDate {
        switch self {
        case .Daily:
            return {date in
                return date.dateByAddingTimeInterval(86400)
            }
        case .Weekly:
            return {date in
                return date.dateByAddingTimeInterval(604800)
            }
        case .Monthly:
            return {date in
                return date.dateByAddingTimeInterval(16934400)
            }
        }
    }
}

class RepeatEventCreator: NSObject {
    func createEvent(startDate startDate: NSDate, endDate: NSDate, calculateNextDate: (NSDate)->NSDate, useDate: (NSDate)->(), finalCall:((NSDate)->())? = nil) {
        useDate(startDate)
        var nextDate = startDate
        while endDate.compare(endDate) == .OrderedAscending {
            nextDate = calculateNextDate(nextDate)
            useDate(nextDate)
        }
        finalCall?(nextDate)
    }
    
    func createEvent(startDate startDate: NSDate, endDate: NSDate, repeatType: RepeatType, useDate: (NSDate)->(), finalCall:((NSDate)->())? = nil) {
        createEvent(startDate: startDate, endDate: endDate, calculateNextDate: repeatType.calculateNextDate, useDate: useDate, finalCall: finalCall)
    }
}


