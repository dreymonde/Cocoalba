import XCTest
@testable import Cocoalba

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

}
