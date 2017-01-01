import Foundation

precedencegroup Apply {
    associativity: left
    lowerThan: AdditionPrecedence
}

infix operator <* : Apply

func <* <T, V> (lhs: T, rhs: (T) -> V) -> V {
    return rhs(lhs)
}

func usage() {
    
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
    
}
