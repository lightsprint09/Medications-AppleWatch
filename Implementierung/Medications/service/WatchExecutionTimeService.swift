//
//  WatchExecutionTimeService.swift
//  Medications
//
//  Created by Lukas Schmidt on 12.10.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import WatchConnectivity

class WatchExecutionTimeService: NSObject, WCSessionDelegate {
    private let markAsTakenEventName = "mark_as_taken_event"
    private let wcSessionNameSpace = ""
    private let session: WCSession
    private let didMarkExececutionTimeTaken: ((String, NSDate)->())?
    
    init(session: WCSession, didMarkExececutionTimeTaken:((String, NSDate)->())?) {
        self.session = session
        self.didMarkExececutionTimeTaken = didMarkExececutionTimeTaken
        super.init()
         WCSessionManager.sharedInstace.registerDelegateWithNameSpace(self, nameSpace:wcSessionNameSpace)
    }
    
    func markExecutionTimeAsTaken(objectIDURLString: String) {
        let eventName = wcSessionNameSpace + markAsTakenEventName
        send([eventName: objectIDURLString])
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
        if let objectID = message[markAsTakenEventName] as? String {
            didMarkExececutionTimeTaken?(objectID, NSDate())
        }
    }
    
    func session(session: WCSession, didReceiveUserInfo userInfo: [String : AnyObject]) {
        recieveData(userInfo)
    }
}
