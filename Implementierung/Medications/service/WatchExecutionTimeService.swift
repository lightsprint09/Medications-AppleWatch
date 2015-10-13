//
//  WatchExecutionTimeService.swift
//  Medications
//
//  Created by Lukas Schmidt on 12.10.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import WatchConnectivity
import UIKit

class WatchExecutionTimeService: NSObject, WCSessionDelegate {
    private let wcSessionNameSpace = "WatchExecutionTimeService"
    private let markAsTakenEventName = "-mark_as_taken_event"
    private let session: WCSession
    private let didMarkExececutionTimeTaken: ((UILocalNotification, Int)->())?
    
    init(session: WCSession, didMarkExececutionTimeTaken:((UILocalNotification, Int)->())?) {
        self.session = session
        self.didMarkExececutionTimeTaken = didMarkExececutionTimeTaken
        super.init()
         WCSessionManager.sharedInstace.registerDelegateWithNameSpace(self, nameSpace:wcSessionNameSpace)
    }
    
    func markExecutionTimeAsTaken(localNotification: UILocalNotification, delaySeconds:Int) {
        let eventName = wcSessionNameSpace + markAsTakenEventName
        var userInfo = localNotification.userInfo!
        userInfo["fireDate"] = localNotification.fireDate
        userInfo["delaySeconds"] = delaySeconds
        send([eventName: userInfo])
    }
    
    private func send(message:[String : AnyObject]) {
        if session.reachable {
            session.sendMessage(message, replyHandler: nil, errorHandler: onError)
        } else {
            session.transferUserInfo(message)
        }
    }
    
    func onError(error:NSError) {
        
    }
    
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject]) {
        recieveData(message)
    }
    
    func recieveData(message:[String: AnyObject]) {
        if let userInfo = message[wcSessionNameSpace + markAsTakenEventName] as? [NSObject: AnyObject], let delaySeconds = userInfo["delaySeconds"] as? Int {
            let notification = UILocalNotification()
            notification.fireDate = userInfo["fireDate"] as? NSDate
            notification.userInfo = userInfo
            didMarkExececutionTimeTaken?(notification, delaySeconds)
        }
    }
    
    func session(session: WCSession, didReceiveUserInfo userInfo: [String : AnyObject]) {
        recieveData(userInfo)
    }
}
