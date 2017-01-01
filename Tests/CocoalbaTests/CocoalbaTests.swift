import XCTest
@testable import Cocoalba

class CocoalbaTests: XCTestCase {
    
    func testOperation() {
        let operation = Operation()
        operation.kvoProxy(atKey: "isFinished").listen { (isFinished: Bool) in
            print(isFinished)
        }
    }

}
