//
//  ExecutionTimesServiceTest.swift
//  Medications
//
//  Created by Lukas Schmidt on 12.10.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import XCTest

class ExecutionTimesServiceTest: AbstractCoreDataTest {
    let executionTimeService = ExecutionTimeService()
    
    
    override func setUp() {
    }
    
       
    func testCreateRootExecuttionTime() {
        let date = NSDate()
        let rootExecutionTime = executionTimeService.createRootExecutionTime(managedObjectContext, assignmentDate: date)
        XCTAssertEqual(rootExecutionTime.assignmentTime, date)
    }

}
