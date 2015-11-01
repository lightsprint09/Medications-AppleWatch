//
//  ExcutionTimeProtocol.swift
//  Medications
//
//  Created by Lukas Schmidt on 29.10.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import Foundation

private let dateFormatter = NSDateFormatter()

@objc protocol ExecutionTimeProtocol {
    var amount: NSDecimalNumber? { get set}
    var assignmentDate: NSDate { get set}
    var assignmentTimeOfDay: NSNumber { get set}
    var creationDate: NSDate { get set}
    var executionDate: NSDate? { get set}
    var secondsMoved: NSNumber? { get set}
    var notExecuted: NSNumber { get set}
    
    var timeString: String { get }
    var amountUnitString: String? { get }
    var drugName: String? { get }
    var drugImage: NSData? { get }
    var codingData:[String: NSObject] { get }
}

extension ExecutionTimeProtocol {
    var timeOfDay: TimeOfDay {
        return TimeOfDay(rawValue: assignmentTimeOfDay.integerValue)!
    }
    
    var hasTakenMedication: Bool {
        return executionDate != nil
    }
    
}
