import XCTest
@testable import Lottery

final class LotteryMainTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        LotteryMain.printerType = PrinterMock.self
    }
    
    // MARK: - Tests
    
    func test_main_properExecution() async {
        LotteryMain.arguments = ["--minimumNumber", "1", "--maximumNumber", "10", "--count", "10"]
        
        await LotteryMain.main()
        
        XCTAssertEqual("[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]", PrinterMock.printed.last)
    }
    
    func test_main_minimumNumberError() async {
        LotteryMain.arguments = ["--maximumNumber", "49", "--count", "6"]
        
        await LotteryMain.main()
        
        XCTAssertEqual("Error: Argument \"Minimum number\" is missing", PrinterMock.printed.last)
    }
    
    func test_main_maximumNumberError() async {
        LotteryMain.arguments = ["--minimumNumber", "1", "--count", "6"]
        
        await LotteryMain.main()
        
        XCTAssertEqual("Error: Argument \"Maximum number\" is missing", PrinterMock.printed.last)
    }
    
    func test_main_countError() async {
        LotteryMain.arguments = ["--minimumNumber", "1", "--maximumNumber", "49"]
        
        await LotteryMain.main()
        
        XCTAssertEqual("Error: Argument \"Count\" is missing", PrinterMock.printed.last)
    }
    
    func test_main_minimumNumberIsGreaterThanMaximumNumberError() async {
        LotteryMain.arguments = ["--minimumNumber", "11", "--maximumNumber", "10", "--count", "10"]
        
        await LotteryMain.main()
        
        XCTAssertEqual("Error: Argument \"Minimum number\" is greater than argument \"Maximum number\"", PrinterMock.printed.last)
    }
    
    func test_main_countIsGreaterThanAllNumbersCountError() async {
        LotteryMain.arguments = ["--minimumNumber", "1", "--maximumNumber", "10", "--count", "20"]
        
        await LotteryMain.main()
        
        XCTAssertEqual("Error: Argument \"Count\" is greater than all numbers count", PrinterMock.printed.last)
    }
    
}

// MARK: - Helpers

private struct PrinterMock: Printer {
    
    static private(set) var printed: [String] = []
    
    static func display(text: String) {
        printed.append(text)
    }
    
}
