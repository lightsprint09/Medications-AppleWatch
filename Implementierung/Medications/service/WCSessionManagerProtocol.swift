//
//  WCSessionManagerProtocol.swift
//  Medications
//
//  Created by Lukas Schmidt on 14.10.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import Foundation
import WatchConnectivity

protocol WCSessionManagerProtocol: WCSessionDelegate {
    var session: WCSession { get }
    func registerDelegate(delegate: WCSessionManagerDelegate)
}

protocol WCSessionManagerDelegate: WCSessionDelegate {
    var namespace: String { get }
    var sessionManager: WCSessionManagerProtocol { get }
}

extension WCSessionManagerDelegate {
    var session: WCSession {
        return sessionManager.session
    }
}