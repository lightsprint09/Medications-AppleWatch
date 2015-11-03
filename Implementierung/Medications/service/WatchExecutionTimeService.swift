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
    private let getTodayExecutionTimeEventName = "-get_today_executionTime"
    private let updateEventName = "-update_execution_time"
    
    let sessionManager: WCSessionManagerProtocol
    
    var didUpdateExecutionTime: (([String: NSObject])->())?
    var fetchExecutionTimesFunction: (()->  Array<ExecutionTimeProtocol>)?
    
    init(sessionManager: WCSessionManagerProtocol) {
        self.sessionManager = sessionManager
        super.init()
        self.sessionManager.registerDelegate(self)
    }
    
    func updateExecutionTime(executionTime: ExecutionTimeProtocol) {
        let eventName = namespace + updateEventName
        send([eventName: executionTime.codingData])
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
            let dataTranform = fetchExecutionTimesFunction().map({(obj) in
                return obj.codingData
            })
            replyHandler(["hu": dataTranform])
        }
    }
    
    func recieveData(message:[String: AnyObject]) {
        if let userInfo = message[namespace + updateEventName] as? [String: NSObject] {
            didUpdateExecutionTime?(userInfo)
        }
    }
    
    func session(session: WCSession, didReceiveUserInfo userInfo: [String : AnyObject]) {
        recieveData(userInfo)
    }
}
