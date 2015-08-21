//
//  DayTimeSource.swift
//  Medications
//
//  Created by Lukas Schmidt on 20.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import Foundation

class DaytimeMedication: NSObject {
    var timeString: String
    var count = 0
    var name: String
    
    init(timeString:String, name:String) {
        self.timeString = timeString
        self.name = name
        super.init()
    }
}

class DayTimeSource: NSObject {
    var source = [DaytimeMedication(timeString: "8:10", name: "Morgen"), DaytimeMedication(timeString: "12:00", name: "Mittag"), DaytimeMedication(timeString: "18:30", name: "Abend")]
    
}
