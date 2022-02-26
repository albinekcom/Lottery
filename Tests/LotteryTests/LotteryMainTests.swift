import XCTest
@testable import Lottery

final class LotteryMainTests: XCTestCase {
    
    func test_main() async {
        await LotteryMain.main()
        
        XCTAssertTrue(true)
    }
    
}
