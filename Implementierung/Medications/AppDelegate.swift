//
//  AppDelegate.swift
//  Medications
//
//  Created by Lukas Schmidt on 17.07.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    lazy var managedObjectContext = CoreDataStack().createMainContext()
    let executionTimeService = ExecutionTimeService()


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        application.registerUserNotificationSettings(NotificationSettings.notificationSettings)
        application.cancelAllLocalNotifications()
        guard let rootTabController = window?.rootViewController as? ManagedObjectContextSettable else {
           return true
        }
        var rtc = rootTabController
        rtc.managedObjectContext = managedObjectContext
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        managedObjectContext.saveOrRollback()
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
    }
    
    func openDelayUI(executionTime: ExecutionTime) {
        if let rootTabController = (window?.rootViewController as? UITabBarController)?.viewControllers?.first as? UINavigationController, let medicationViewController = rootTabController.topViewController as? ExecutionTimesTableViewController {
            medicationViewController.askForDelay(executionTime)
        }
    }
    

    func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forLocalNotification notification: UILocalNotification, withResponseInfo responseInfo: [NSObject : AnyObject], completionHandler: () -> Void) {
        guard let identifier = identifier, let codingData = notification.userInfo as? [String: NSObject],
            let executionTime = executionTimeService.getExecutionTimeForCodingData(managedObjectContext, codingData: codingData) else { completionHandler(); return }
        switch identifier {
        case takeMedicationNotificationActionIdentifier:
            executionTime.executionDate = NSDate()
            managedObjectContext.saveOrRollback()
            
            break
        case delayMedicationNotificationActionIdentifier:
            openDelayUI(executionTime)
            break
        default: break
       
        }
        completionHandler()
    }

    
}

