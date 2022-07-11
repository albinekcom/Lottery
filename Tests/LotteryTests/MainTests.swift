import XCTest
@testable import Lottery

final class MainTests: XCTestCase {
    
    private var printer: PrinterMock!
    private var lottery: LotteryStub!
    
    override func setUp() {
        super.setUp()
        
        printer = PrinterMock()
        lottery = LotteryStub()
        
        Main.printer = printer
        Main.lottery = lottery
    }
    
    // MARK: - Tests
    
    func test_something() {
        XCTAssertTrue(true)
    }
    
    @MainActor func test_main_properExecution() throws {
        Main.userArguments = .stub

        try Main.main()

        XCTAssertEqual("[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]", printer.displayed.last)
    }
//
//    func test_main_minimumNumberError() async {
//        LotteryMain.arguments = ["--maximumNumber", "49", "--count", "6"]
//
//        await LotteryMain.main()
//
//        XCTAssertEqual("Error: Argument \"Minimum number\" is missing", PrinterMock.printed.last)
//    }
//
//    func test_main_maximumNumberError() async {
//        LotteryMain.arguments = ["--minimumNumber", "1", "--count", "6"]
//
//        await LotteryMain.main()
//
//        XCTAssertEqual("Error: Argument \"Maximum number\" is missing", PrinterMock.printed.last)
//    }
//
//    func test_main_countError() async {
//        LotteryMain.arguments = ["--minimumNumber", "1", "--maximumNumber", "49"]
//
//        await LotteryMain.main()
//
//        XCTAssertEqual("Error: Argument \"Count\" is missing", PrinterMock.printed.last)
//    }
//
//    func test_main_minimumNumberIsGreaterThanMaximumNumberError() async {
//        LotteryMain.arguments = ["--minimumNumber", "11", "--maximumNumber", "10", "--count", "10"]
//
//        await LotteryMain.main()
//
//        XCTAssertEqual("Error: Argument \"Minimum number\" is greater than argument \"Maximum number\"", PrinterMock.printed.last)
//    }
//
//    func test_main_countIsGreaterThanAllNumbersCountError() async {
//        LotteryMain.arguments = ["--minimumNumber", "1", "--maximumNumber", "10", "--count", "20"]
//
//        await LotteryMain.main()
//
//        XCTAssertEqual("Error: Argument \"Count\" is greater than all numbers count", PrinterMock.printed.last)
//    }
//
//    func test_main_lotteryThrowsUnknownError() async {
//        LotteryMain.arguments = ["--minimumNumber", "1", "--maximumNumber", "10", "--count", "5"]
//        LotteryMain.lotteryType = LotteryStub.self
//
//        await LotteryMain.main()
//
//        XCTAssertEqual("Error: something went wrong", PrinterMock.printed.last)
//    }
    
}

// MARK: - Helpers

private final class PrinterMock: Printer {
    
    private(set) var displayed: [String] = []
    
    func display(text: String) {
        displayed.append(text)
    }
    
}

private struct LotteryStub: AnyLottery {
    
    enum Error: Swift.Error {
        
        case unknown
        
    }
    
    func results(minimumNumber: Int, maximumNumber: Int, count: Int) throws -> [Int] {
        throw Error.unknown
    }
    
}

extension UserArguments {
    
    static let stub: UserArguments = try! UserArguments(arguments: ["--minimumNumber", "1", "--maximumNumber", "10", "--count", "10"])
    
}
