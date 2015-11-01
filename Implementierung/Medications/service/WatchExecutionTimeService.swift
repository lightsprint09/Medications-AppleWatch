//
//  WatchExecutionTimeService.swift
//  Medications
//
//  Created by Lukas Schmidt on 12.10.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import WatchConnectivity
import UIKit

class WatchExecutionTimeService: NSObject, WCSessionManagerDelegate {
    let namespace = "WatchExecutionTimeService"
    private let delayExecutionTimeEventName = "-delay_executionTime"
    private let getTodayExecutionTimeEventName = "-get_today_executionTime"
    private let markAsTakenEventName = "-mark_as_taken"
    
    let sessionManager: WCSessionManagerProtocol
    
    var didDelayExecutionTime: ((UILocalNotification, Int)->())?
    var didExecuteExecutionTime: ((UILocalNotification)->())?
    var fetchExecutionTimesFunction: (()->  Array<[String: NSObject]>)?
    
    init(sessionManager: WCSessionManagerProtocol) {
        self.sessionManager = sessionManager
        super.init()
        self.sessionManager.registerDelegate(self)
    }
    
    func delayExecutionTimeFromNotification(var localNotificationUserInfo: [String: AnyObject], delaySeconds:Int) {
        let eventName = namespace + delayExecutionTimeEventName
        localNotificationUserInfo["delaySeconds"] = delaySeconds
        send([eventName: localNotificationUserInfo])
    }
    
    func executeExecutionTimeWithNotification(localNotificationUserInfo: [String: AnyObject]) {
        let eventName = namespace + markAsTakenEventName
        send([eventName: localNotificationUserInfo])
    }
    
    private func send(message:[String : AnyObject]) {
        if session.reachable {
            session.sendMessage(message, replyHandler: nil, errorHandler: onError)
        } else {
            session.transferUserInfo(message)
        }
    }
    
    func onError(error:NSError) {
       print(error)
    }
    
    func fetchExecutionTimesOfToday(callback:(Array<WatchExecutionTimeContext>)->()) {
        let eventName = namespace + getTodayExecutionTimeEventName
        session.sendMessage([eventName: ""], replyHandler: {data in
            dispatch_async(dispatch_get_main_queue(), {
                if let list = data["hu"] as? Array<Dictionary<String, NSObject>>{
                    let executionTimeList: Array<WatchExecutionTimeContext> = list.map({(dict) in
                        let executionTime = WatchExecutionTime(watchtData: dict)
                        return WatchExecutionTimeContext(executionTimeService: self, executionTime: executionTime)
                    })
                    callback(executionTimeList)
                }})
        }, errorHandler: onError)
    }
    
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject]) {
        recieveData(message)
    }
    
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
        if let fetchExecutionTimesFunction = fetchExecutionTimesFunction {
            replyHandler(["hu": fetchExecutionTimesFunction()])
        }
    }
    
    func recieveData(message:[String: AnyObject]) {
        if let userInfo = message[namespace + delayExecutionTimeEventName] as? [String: AnyObject],
            let delaySeconds = userInfo["delaySeconds"] as? Int {
            let notification = UILocalNotification()
            notification.fireDate = userInfo["fireDate"] as? NSDate
            notification.userInfo = userInfo
            didDelayExecutionTime?(notification, delaySeconds)
        }
        if let userInfo = message[namespace + markAsTakenEventName] as? [String: AnyObject] {
                let notification = UILocalNotification()
                notification.fireDate = userInfo["fireDate"] as? NSDate
                notification.userInfo = userInfo
                didExecuteExecutionTime?(notification)
        }
    }
    
    func session(session: WCSession, didReceiveUserInfo userInfo: [String : AnyObject]) {
        recieveData(userInfo)
    }
}
