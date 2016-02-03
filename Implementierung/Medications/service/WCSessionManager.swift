//
//  WCSessionMultiUse.swift
//  CardScore
//
//  Created by Lukas Schmidt on 23.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import Foundation
import WatchConnectivity

class WCSessionManager: NSObject, WCSessionManagerProtocol {
    private var delegates = Dictionary<String, WCSessionDelegate>()
    var session: WCSession
    
    static let sharedInstace = WCSessionManager()
    
    private override init() {
        session = WCSession.defaultSession()
        super.init()
        session.delegate = self
    }
    
    func activate() {
        session.activateSession()
    }
    
    func registerDelegate(delegate: WCSessionManagerDelegate) {
        delegates[delegate.namespace] = delegate
    }
    
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject]) {
        guard let key = message.keys.first, let nameSpace = extractNameSpace(key), let delegate = delegateOfNameSpace(nameSpace) else { return }
        delegate.session!(session, didReceiveMessage: message)
    }
    
    func session(session: WCSession, didReceiveUserInfo userInfo: [String : AnyObject]) {
         guard let key = userInfo.keys.first, let nameSpace = extractNameSpace(key), let delegate = delegateOfNameSpace(nameSpace) else { return }
        delegate.session!(session, didReceiveUserInfo: userInfo)
    }
    
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
        guard let key = message.keys.first, let nameSpace = extractNameSpace(key), let delegate = delegateOfNameSpace(nameSpace) else { return }
        delegate.session!(session, didReceiveMessage: message, replyHandler: replyHandler)
    }
    
    func delegateOfNameSpace(nameSpace:String) ->WCSessionDelegate? {
        return delegates[nameSpace]
    }
    
    func extractNameSpace(key:NSString) -> String? {
        return key.componentsSeparatedByString("-").first
    }
    
    func session(session: WCSession, didFinishUserInfoTransfer userInfoTransfer: WCSessionUserInfoTransfer, error: NSError?) {
      
    }
}
