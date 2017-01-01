import Alba
import Foundation

public extension Notification.Name {
    
    var proxy: PublisherProxy<[AnyHashable : Any]?> {
        return PublisherProxy(subscribe: { (ident, handler) in
            NotificationCenter.default.addObserver(forName: self,
                                                   object: nil,
                                                   queue: nil) { handler($0.userInfo) }
        }, unsubscribe: { _ in })
    }
        
}
