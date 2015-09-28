//
//  NSDateCreation.swift
//  Medications
//
//  Created by Lukas Schmidt on 25.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import Foundation

extension NSDate {
    static func dateWithHour(hour:Int, minutes:Int) ->NSDate {
        let calender = NSCalendar.currentCalendar()
        return calender.dateBySettingHour(hour, minute: minutes, second: 0, ofDate: NSDate(), options: NSCalendarOptions.MatchFirst)!
    }
}