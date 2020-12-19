@testable import LotteryCore
import XCTest

final class LotteryArgumentsParserTests: XCTestCase {

    func testReturningMinimumNumberError() {
        let result = LotteryArgumentsParser().parse(arguments: ["--maximumNumber", "49", "--count", "6"])

        XCTAssertEqual(result, .failure(.minimumNumberError))
    }

    func testReturningMaximumNumberError() {
        let result = LotteryArgumentsParser().parse(arguments: ["--minimumNumber", "1", "--count", "6"])

        XCTAssertEqual(result, .failure(.maximumNumberError))
    }

    func testReturningCountError() {
        let result = LotteryArgumentsParser().parse(arguments: ["--minimumNumber", "1", "--maximumNumber", "49"])

        XCTAssertEqual(result, .failure(.countError))
    }

    func testParsingInNormalOrder() {
        let result = LotteryArgumentsParser().parse(arguments: ["--minimumNumber", "1", "--maximumNumber", "49", "--count", "6"])

        XCTAssertEqual(result, .success(LotteryArguments(minimumNumber: 1, maximumNumber: 49, count: 6)))
    }

    func testParsingInDifferentOrder() {
        let result = LotteryArgumentsParser().parse(arguments: ["--count", "6", "--maximumNumber", "49", "--minimumNumber", "1"])

        XCTAssertEqual(result, .success(LotteryArguments(minimumNumber: 1, maximumNumber: 49, count: 6)))
    }

    func testThrowingCountErrorWhenOnlyValueIsMissing() {
        let result = LotteryArgumentsParser().parse(arguments: ["--minimumNumber", "1", "--maximumNumber", "49", "--count"])

        XCTAssertEqual(result, .failure(.countError))
    }

    func testReturningMinimumNumberErrorWhenNotANumberProvided() {
        let result = LotteryArgumentsParser().parse(arguments: ["--minimumNumber", "a"])

        XCTAssertEqual(result, .failure(.minimumNumberError))
    }

}
