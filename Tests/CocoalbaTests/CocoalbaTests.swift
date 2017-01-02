import XCTest
@testable import Cocoalba
#if os(iOS)
    import UIKit
#endif

class CocoalbaTests: XCTestCase {
    
    func testProgress() {
        
        let progress = Progress()
        let expectation = self.expectation(description: "on progress")
        progress.kvoProxy(atKey: .totalUnitCount).listen { (int: Int) in
            XCTAssertEqual(int, 10)
            expectation.fulfill()
        }
        
        progress.totalUnitCount = 10
        waitForExpectations(timeout: 5.0)
        
    }
    
    func testNotifications() {
        
        let expectation = self.expectation(description: "on not")
        Notification.Name("TommyHilfiger").proxy.listen { (notification) in
            XCTAssertEqual(notification.userInfo!["3"] as! String, "Pack")
            expectation.fulfill()
        }
        
        NotificationCenter.default.post(name: .init("TommyHilfiger"), object: nil, userInfo: ["3": "Pack"])
        waitForExpectations(timeout: 5.0)
        
    }
    
    #if os(iOS)
    
    func testControl() {
        let switc = UISwitch()
        let expectation = self.expectation(description: "on switch")
        switc.proxy(forControlEvents: .valueChanged).listen {
            XCTAssertEqual(switc.isOn, true)
            expectation.fulfill()
        }
        switc.isOn = true
        waitForExpectations(timeout: 5.0)
    }
    
    #endif

}
