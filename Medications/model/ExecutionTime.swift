//
//  ExecutionTime.swift
//  Medications
//
//  Created by Lukas Schmidt on 10.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import Foundation
import CoreData

class ExecutionTime: NSManagedObject {

    var timeOfDay: TimeOfDay {
        get{
            return TimeOfDay(rawValue: self.assignmentTimeOfDay.integerValue)!
        }
    }

}
