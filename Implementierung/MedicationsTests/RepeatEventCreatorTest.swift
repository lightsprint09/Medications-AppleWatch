//
//  RepeatEventCreatorTest.swift
//  Medications
//
//  Created by Lukas Schmidt on 10.10.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import XCTest

class RepeatEventCreatorTest: XCTestCase {
    let eventCreator = RepeatEventCreator()
    
    func testDaily() {
        let startDate = NSDate()
        var count = 0
        eventCreator.createEvent(startDate: startDate, endDate: startDate.dateByAddingTimeInterval(604800), repeatType: .Daily, useDate: {(date) in
            count++
        })
        XCTAssertEqual(count, 7)
    }
    
    func testWeekly() {
        let startDate = NSDate()
        var count = 0
        eventCreator.createEvent(startDate: startDate, endDate: startDate.dateByAddingTimeInterval(4 * 604800), repeatType: .Weekly, useDate: {(date) in
            count++
        })
        XCTAssertEqual(count, 4)
    }
    
    func testMonthly() {
        let startDate = NSDate()
        var count = 0
        eventCreator.createEvent(startDate: startDate, endDate: startDate.dateByAddingTimeInterval(12 * 16934400), repeatType: .Monthly, useDate: {(date) in
            count++
        })
        XCTAssertEqual(count, 12)
    }
}
