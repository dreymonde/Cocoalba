import Alba
import Foundation

public extension Notification.Name {
    
    var proxy: PublisherProxy<(object: Any?, userInfo: [AnyHashable : Any]?)> {
        return PublisherProxy(subscribe: { (ident, handler) in
            NotificationCenter.default.addObserver(forName: self,
                                                   object: nil,
                                                   queue: nil) { handler(object: $0.object,
                                                                         userInfo: $0.userInfo) }
        }, unsubscribe: { _ in })
    }
        
}
