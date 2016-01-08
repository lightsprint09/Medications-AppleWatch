

class WatchExecutionTimeService: NSObject, WCSessionManagerDelegate {
    private let fetchExecutionTimesEventName = "fetchExecutionTimes"
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
  /.../
    func fetchExecutionTimesOfToday(callback:(Array<WatchExecutionTimeContext>)->()) {
        let eventName = namespace + getTodayExecutionTimeEventName
        session.sendMessage([eventName: ""], replyHandler: {data in
            guard let contexts = self.executionTimesContextsFromDict(data) else { return }
            dispatch_async(dispatch_get_main_queue(), {
                callback(contexts)
            })
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
            replyHandler([fetchExecutionTimesEventName: dataTranform])
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
