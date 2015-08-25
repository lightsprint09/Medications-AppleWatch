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
        if hour > 5 && hour < 11 {
            return Morning
        }
        if hour > 11 && hour < 17 {
            return Noon
        }
        if hour > 17 && hour < 22 {
            return Evening
        }
        if hour > 22 && hour < 5 {
            return Night
        }
        return Night
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