import Alba
import Foundation

public extension Notification.Name {
    
    var proxy: Subscribe<Notification> {
        return Subscribe(subscribe: { (ident, handler) in
            NotificationCenter.default.addObserver(forName: self,
                                                   object: nil,
                                                   queue: nil) { handler($0) }
        }, unsubscribe: { _ in },
           payload: ProxyPayload.empty.adding(entry: .publisherLabel(self.rawValue, type: Notification.Name.self)))
    }
    
    func proxy(object: Any?, queue: OperationQueue? = nil) -> Subscribe<Notification> {
        return Subscribe.init(subscribe: { (ident, handler) in
            NotificationCenter.default.addObserver(forName: self,
                                                   object: object,
                                                   queue: queue,
                                                   using: { handler($0) })
        }, unsubscribe: { _ in },
           payload: ProxyPayload.empty.adding(entry: .publisherLabel(self.rawValue, type: Notification.Name.self)))
    }
    
}
