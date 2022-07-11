import XCTest
@testable import Lottery

final class MainTests: XCTestCase {
    
    private var printer: PrinterMock!
    private var lottery: AnyLottery!
    
    // MARK: - Setting
    
    override func setUp() {
        super.setUp()
        
        printer = PrinterMock()
        lottery = LotteryStub()
        
        Main.printer = printer
        Main.lottery = Lottery()
    }
    
    // MARK: - Tests
    
    func test_main_properExecution() async throws {
        Main.arguments = [
            "--minimumNumber",
            "1",
            "--maximumNumber",
            "10",
            "--count",
            "10"
        ]

        try await Main.main()

        XCTAssertEqual(
            "[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]",
            printer.displayed.first
        )
    }
    
    func test_main_minimumNumberError() async {
        Main.arguments = [
            "--maximumNumber",
            "49",
            "--count",
            "6"
        ]
        
        do {
            try await Main.main()
        } catch {
            XCTAssertEqual(
                error as! UserArgumentsError,
                .minimumNumberError
            )
        }
    }

    func test_main_maximumNumberError() async throws {
        Main.arguments = [
            "--minimumNumber",
            "1",
            "--count",
            "6"
        ]

        do {
            try await Main.main()
        } catch {
            XCTAssertEqual(
                error as! UserArgumentsError,
                .maximumNumberError
            )
        }
    }
    
    func test_main_countError() async throws {
        Main.arguments = [
            "--minimumNumber",
            "1",
            "--maximumNumber",
            "49"
        ]

        do {
            try await Main.main()
        } catch {
            XCTAssertEqual(
                error as! UserArgumentsError,
                .countError
            )
        }
    }
    
    func test_main_minimumNumberIsGreaterThanMaximumNumberError() async throws {
        Main.arguments = [
            "--minimumNumber",
            "11",
            "--maximumNumber",
            "10",
            "--count",
            "10"
        ]

        do {
            try await Main.main()
        } catch {
            XCTAssertEqual(
                error as! LotteryError,
                .minimumNumberIsGreaterThanMaximumNumber
            )
        }
    }
    
    func test_main_countIsGreaterThanAllNumbersCountError() async throws {
        Main.arguments = [
            "--minimumNumber",
            "1",
            "--maximumNumber",
            "10",
            "--count",
            "20"
        ]

        do {
            try await Main.main()
        } catch {
            XCTAssertEqual(
                error as! LotteryError,
                .countIsGreaterThanAllNumbersCount
            )
        }
    }
    
    func test_main_lotteryThrowsUnknownError() async throws {
        Main.arguments = [
            "--minimumNumber",
            "1",
            "--maximumNumber",
            "10",
            "--count",
            "5"
        ]
        
        Main.lottery = LotteryStub()

        do {
            try await Main.main()
        } catch {
            XCTAssertEqual(
                error as! LotteryStub.Error,
                .unknown
            )
        }
    }
    
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
