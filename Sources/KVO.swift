import Alba
import Foundation

public protocol KeyValueObservableKey {
    var key: String { get }
}

extension KeyValueObservableKey where Self : RawRepresentable, Self.RawValue == String {
    public var key: String {
        return rawValue
    }
}

public protocol KeyValueObservable {
    associatedtype ObservableKeys: KeyValueObservableKey
}

private var albaObservationContext = 0

internal final class KeyValuePublisher<ObservableObject : NSObject, Event> : NSObject {
    
    internal let key: String
    internal let object: ObservableObject
    
    internal init(of object: ObservableObject, atKey key: String) {
        self.key = key
        self.object = object
        super.init()
        register()
    }
    
    private let publisher = Publisher<Event>()
    var proxy: Subscribe<Event> {
        return publisher.proxy
    }
    
    deinit {
        object.removeObserver(self, forKeyPath: key)
    }
    
    private func register() {
        object.addObserver(self, forKeyPath: key, options: [.new], context: &albaObservationContext)
    }
    
    internal override func observeValue(forKeyPath keyPath: String?,
                                        of object: Any?,
                                        change: [NSKeyValueChangeKey : Any]?,
                                        context: UnsafeMutableRawPointer?) {
        guard context == &albaObservationContext else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            return
        }
        guard let keyPath = keyPath, keyPath == self.key else {
            return
        }
        if let newValue = change?[.newKey] as? Event {
            publisher.publish(newValue)
        } else {
            fatalError("\(change?[.newKey]) is not of type \(Event.self): kvo on \(key) of \(self.object)")
        }
    }
    
}

extension KeyValuePublisher where ObservableObject : KeyValueObservable {
    
    internal convenience init(of object: ObservableObject, atKey key: ObservableObject.ObservableKeys) {
        self.init(of: object, atKey: key.key)
    }
    
}

public extension NSObject {
    
    func kvoProxy<Event>(atKey key: String) -> Subscribe<Event> {
        return KeyValuePublisher(of: self, atKey: key).proxy
    }
    
}

public extension KeyValueObservable where Self : NSObject {
    
    func kvoProxy<Event>(atKey key: ObservableKeys) -> Subscribe<Event> {
        return KeyValuePublisher(of: self, atKey: key).proxy
    }
    
}

extension Progress : KeyValueObservable {
    public enum ObservableKeys : String, KeyValueObservableKey {
        case fractionCompleted
        case completedUnitCount
        case totalUnitCount
        case cancelled
        case paused
    }
}

