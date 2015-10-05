//
//  ExecutionTimeService.swift
//  Medications
//
//  Created by Lukas Schmidt on 28.09.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import Foundation
import CoreData

public let coreDataNotificationIDKey = "coreDataNotificationIDKey"

class ExecutionTimeService: NSObject {
    
    func rootExecutionTimeFetchRequest(drug:Drug) -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: RootExecutionTime.entityName)
        let sortDiscriptor = NSSortDescriptor(key: "assignmentTime", ascending: true)
        fetchRequest.sortDescriptors = [sortDiscriptor]
        fetchRequest.predicate = NSPredicate(format: "drug == %@", drug)
        
        return fetchRequest
    }
    
    func allChildrenExecutionTimesFetchRequest() -> NSFetchRequest {
        let request = NSFetchRequest(entityName: ExecutionTime.entityName)
        request.sortDescriptors = [NSSortDescriptor(key: "assignmentDate", ascending: true)]
        
        return request
    }
    
    func createRootExecutionTime(context: NSManagedObjectContext, assignmentDate:NSDate) -> RootExecutionTime {
        let executionTime = context.insertObject() as RootExecutionTime
        executionTime.assignmentTime = assignmentDate
        
        return executionTime
    }
    
    func updateExecuitonTime(executionTime: RootExecutionTime, assignmentDate: NSDate, amount: Double) {
        executionTime.assignmentTime = assignmentDate
        executionTime.amount = NSDecimalNumber(double: amount)
        
        //TODO cascade update of child times
    }
    
    func createChildExecutionTimeFromParent(rootExecutionTime:RootExecutionTime, startDate:NSDate, endDate: NSDate) {
        guard let managedObjectContext = rootExecutionTime.managedObjectContext else { return }
        managedObjectContext.saveOrRollback()
        
        let repeatCreator = RepeatEventCreator()
        repeatCreator.createEvent(startDate: startDate, endDate: endDate, repeatType: .Daily, useDate: {date in
            let executionTime = managedObjectContext.insertObject() as ExecutionTime
           
            executionTime.assignmentDate = date
            executionTime.assignmentTimeOfDay = TimeOfDay.timeOfDayFromDate(date).rawValue
            executionTime.parentExecutionTime = rootExecutionTime
            executionTime.creationDate = NSDate()
            executionTime.amount = rootExecutionTime.amount
        })
    }
    
    func createNotification(executionTime:RootExecutionTime) -> UILocalNotification {
        let notification = UILocalNotification()
        notification.fireDate = executionTime.assignmentTime
        notification.repeatInterval = .Day
        notification.category = NotificationSettings.medicationNotificationCategoryIdentifier
        notification.alertBody = "Nehme " + executionTime.amountUnitString! + " " + executionTime.drug!.name
        notification.alertAction = "Eingenommen"
        notification.userInfo = [coreDataNotificationIDKey: executionTime.objectID.URIRepresentation().absoluteString]
        
        return notification
    }
}
