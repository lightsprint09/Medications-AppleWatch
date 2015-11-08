//
//  NSDateCreation.swift
//  Medications
//
//  Created by Lukas Schmidt on 25.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import Foundation

extension NSDate {
    static func dateWithHour(hour:Int, minutes:Int) -> NSDate {
        let calender = NSCalendar.currentCalendar()
        return calender.dateBySettingHour(hour, minute: minutes, second: 0, ofDate: NSDate(), options: .MatchFirst)!
    }
    
    static func startDateAndEndDateFromDay(day: NSDate) -> (NSDate, NSDate) {
        let calendar = NSCalendar.currentCalendar()
        let dateParts = NSCalendarUnit.Year.union(.Month).union(.Day)
        let dateComponents = calendar.components(dateParts, fromDate: NSDate())
        dateComponents.hour = 0
        dateComponents.minute = 0
        dateComponents.second = 0
        
        let startTime = calendar.dateFromComponents(dateComponents)!
        let endTime = startTime.dateByAddingTimeInterval(86400)
        
        return (startTime, endTime)
    }
    
    var startOfDay: NSDate {
        return NSDate.startDateAndEndDateFromDay(self).0
    }
    
    var endOfDay: NSDate {
        return NSDate.startDateAndEndDateFromDay(self).1
    }
}