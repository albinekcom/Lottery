@testable import libLotteryArgumentsParser
import XCTest

final class LotteryArgumentsParserTests: XCTestCase {

    // MARK: - Tests

    func testThrowingMinimumNumberIsMissingError() {
        XCTAssertThrowsError(try LotteryArgumentsParser.parse(arguments: ["--maximumNumber", "49", "--count", "6"])) { error in
            XCTAssertEqual(error as? LotteryArgumentsParserError, LotteryArgumentsParserError.minimumNumberIsMissing)
        }
    }

    func testThrowingMaximumNumberIsMissingError() {
        XCTAssertThrowsError(try LotteryArgumentsParser.parse(arguments: ["--minimumNumber", "1", "--count", "6"])) { error in
            XCTAssertEqual(error as? LotteryArgumentsParserError, LotteryArgumentsParserError.maximumNumberIsMissing)
        }
    }

    func testThrowingCountIsMissingError() {
        XCTAssertThrowsError(try LotteryArgumentsParser.parse(arguments: ["--minimumNumber", "1", "--maximumNumber", "49"])) { error in
            XCTAssertEqual(error as? LotteryArgumentsParserError, LotteryArgumentsParserError.countIsMissing)
        }
    }

    func testThrowingCountIsMissingErrorWhenOnlyValueIsMissing() {
        XCTAssertThrowsError(try LotteryArgumentsParser.parse(arguments: ["--minimumNumber", "1", "--maximumNumber", "49", "--count"])) { error in
            XCTAssertEqual(error as? LotteryArgumentsParserError, LotteryArgumentsParserError.countIsMissing)
        }
    }

    func testNormalParsing() {
        let (minimumNumber, maximumNumber, count) = try! LotteryArgumentsParser.parse(arguments: ["--minimumNumber", "1", "--maximumNumber", "49", "--count", "6"])

        XCTAssertEqual(1, minimumNumber)
        XCTAssertEqual(49, maximumNumber)
        XCTAssertEqual(6, count)
    }

    func testParsingInDifferentOrder() {
        let (minimumNumber, maximumNumber, count) = try! LotteryArgumentsParser.parse(arguments: ["--count", "6", "--maximumNumber", "49", "--minimumNumber", "1", ])

        XCTAssertEqual(1, minimumNumber)
        XCTAssertEqual(49, maximumNumber)
        XCTAssertEqual(6, count)
    }

}
