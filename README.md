# Cocoalba
[Alba](https://github.com/dreymonde/Alba) goodies for Cocoa (simplified KVO and Notifications)

```swift
let operation = Operation()
operation.kvoProxy(atKey: "isFinished").listen { (isFinished: Bool) in
    if isFinished {
        print("Operation did finish")
    }
}

Notification.Name.NSThreadWillExit.proxy.listen { (object, userInfo) in
    if let exitingThread = object as? Thread {
        print("\(exitingThread) is exiting")
    }
}
```
