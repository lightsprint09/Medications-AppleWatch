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
    private let markAsTakenEventName = "-delay_executionTime"
    private let getTodayExecutionTimeEventName = "-get_today_executionTime"
    let sessionManager: WCSessionManagerProtocol
    private let didDelayExecutionTime: ((UILocalNotification, Int)->())?
    var fetchExecutionTimesFunction: (()->NSArray)?
    
    init(sessionManager: WCSessionManagerProtocol, didDelayExecutionTime:((UILocalNotification, Int)->())? = nil) {
        self.sessionManager = sessionManager
        self.didDelayExecutionTime = didDelayExecutionTime
        super.init()
        self.sessionManager.registerDelegate(self)
    }
    
    func delayExecutionTimeFromNotification(var localNotificationUserInfo: [String: AnyObject], delaySeconds:Int) {
        let eventName = namespace + markAsTakenEventName
        localNotificationUserInfo["delaySeconds"] = delaySeconds
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
    
    func fetchExecutionTimesOfToday(callback:(Array<Dictionary<String, NSObject>>)->()) {
        let eventName = namespace + getTodayExecutionTimeEventName
        session.sendMessage([eventName: ""], replyHandler: {data in
            dispatch_async(dispatch_get_main_queue(), {
                if let list = data["hu"] as? Array<Dictionary<String, NSObject>>{
                    callback(list)
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
        if let userInfo = message[namespace + markAsTakenEventName] as? [String: AnyObject],
            let delaySeconds = userInfo["delaySeconds"] as? Int {
            let notification = UILocalNotification()
            notification.fireDate = userInfo["fireDate"] as? NSDate
            notification.userInfo = userInfo
            didDelayExecutionTime?(notification, delaySeconds)
        }
    }
    
    func session(session: WCSession, didReceiveUserInfo userInfo: [String : AnyObject]) {
        recieveData(userInfo)
    }
}
