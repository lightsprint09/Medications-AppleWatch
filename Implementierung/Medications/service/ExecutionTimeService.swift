//
//  ExecutionTimeService.swift
//  Medications
//
//  Created by Lukas Schmidt on 28.09.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import Foundation
import CoreData

class ExecutionTimeService: NSObject {
    func parentExecutionTimeFetchRequest(drug:Drug) -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: ExecutionTime.entityName)
        let sortDiscriptor = NSSortDescriptor(key: "assignmentDate", ascending: true)
        fetchRequest.sortDescriptors = [sortDiscriptor]
        fetchRequest.predicate = NSPredicate(format: "isCreationTime == true AND medication.drug == %@", drug)
        
        return fetchRequest
    }
    
    func allChildrenExecutionTimesFetchRequest() -> NSFetchRequest {
        let request = NSFetchRequest(entityName: ExecutionTime.entityName)
        request.sortDescriptors = [NSSortDescriptor(key: "assignmentDate", ascending: true)]
        request.predicate = NSPredicate(format: "isCreationTime == false")
        
        return request
    }
    
    func createExecutionTime(context: NSManagedObjectContext, medication: Medication, assignmentDate:NSDate) -> ExecutionTime {
        let executionTime = context.insertObject() as ExecutionTime
        executionTime.medication = medication
        executionTime.creationDate = NSDate()
        executionTime.assignmentDate = assignmentDate
        
        return executionTime
    }
    
    func updateExecuitonTime(executionTime: ExecutionTime, assignmentDate: NSDate, amount: Double) {
        let timeOfDay = TimeOfDay.timeOfDayFromDate(assignmentDate)
        executionTime.assignmentDate = assignmentDate
        executionTime.assignmentTimeOfDay = timeOfDay.rawValue
        executionTime.amount = NSDecimalNumber(double: amount)
        
        //TODO cascade update of child times
    }
}
