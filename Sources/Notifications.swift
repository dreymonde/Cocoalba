import Alba
import Foundation
#if os(iOS)
    import UIKit
#endif

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

#if os(iOS)

    internal class UIControlPublisher : NSObject {
        
        let publisher = Publisher<Void>()
        
        let control: UIControl
        let controlEvents: UIControlEvents
        
        init(control: UIControl, forControlEvents controlEvents: UIControlEvents) {
            self.control = control
            self.controlEvents = controlEvents
        }
        
        deinit {
            control.removeTarget(self, action: #selector(handle), for: controlEvents)
        }
        
        private func register() {
            control.addTarget(self, action: #selector(handle), for: controlEvents)
        }
        
        func handle() {
            publisher.publish()
        }
        
    }
    
    public extension UIControl {
        
        func proxy(forControlEvents controlEvents: UIControlEvents) -> PublisherProxy<Void> {
            return UIControlPublisher(control: self, forControlEvents: controlEvents).publisher <* PublisherProxy.init(strong:)
        }
        
    }
    
#endif
