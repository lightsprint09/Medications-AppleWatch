//
//  TimeOfDay.swift
//  Medications
//
//  Created by Lukas Schmidt on 25.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import Foundation

enum TimeOfDay: Int {
    case Morning, Noon, Evening, Night
    
    static func timeOfDayFromDate(date:NSDate) -> TimeOfDay {
        let hour = NSCalendar.currentCalendar().component(NSCalendarUnit.Hour, fromDate: date)
        if hour > 6 && hour < 11 {
            return Morning
        }
        if hour > 11 && hour < 17 {
            return Noon
        }
        if hour > 17 && hour < 22 {
            return Evening
        }
        if hour > 22 && hour < 6 {
            return Night
        }
        return Night
    }
    
    var startDate:NSDate {
        get{
            switch(self) {
            case .Morning:
                return NSDate.dateWithHour(6, minutes: 0)
            case .Noon:
                return NSDate.dateWithHour(11, minutes: 0)
            case .Evening:
                return NSDate.dateWithHour(17, minutes: 0)
            case .Night:
               return NSDate.dateWithHour(22, minutes: 0)
            }
        }
    }
    
    var endDate:NSDate {
        get{
            switch(self) {
            case .Morning:
                return NSDate.dateWithHour(11, minutes: 0)
            case .Noon:
                return NSDate.dateWithHour(17, minutes: 0)
            case .Evening:
                return NSDate.dateWithHour(22, minutes: 0)
            case .Night:
                return NSDate.dateWithHour(6, minutes: 0)
            }
        }
    }
    
    var imageWithColor: UIImage {
        get{
            switch(self) {
            case .Morning:
                return UIImage(named: "glyphicons-232-sun-color")!
            case .Noon:
                return UIImage(named: "glyphicons-232-sun-color")!
            case .Evening:
                return UIImage(named: "glyphicons-232-sun-color")!
            case .Night:
                return UIImage(named: "glyphicons-231-moon-color")!
            }
        }
    }
}