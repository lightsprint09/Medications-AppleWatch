//
//  WatchExecutionTimeContext.swift
//  Medications
//
//  Created by Lukas Schmidt on 01.11.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import Foundation

class WatchExecutionTimeContext: NSObject {
    let executionTimeService: WatchExecutionTimeService
    let executionTime: ExecutionTimeProtocol
    
    init(executionTimeService: WatchExecutionTimeService, executionTime: ExecutionTimeProtocol) {
        self.executionTimeService = executionTimeService
        self.executionTime = executionTime
        super.init()
    }
    
    func delayExecutionTime(seconds: Int) {
        executionTime.secondsMoved = seconds
        executionTimeService.updateExecutionTime(executionTime)
    }
}
