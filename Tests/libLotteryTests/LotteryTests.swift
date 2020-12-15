@testable import libLottery
import XCTest

final class LotteryTests: XCTestCase {

    private var minimumNumber: Int!
    private var maximumNumber: Int!
    private var count: Int!

    // MARK: - Setting

    override func setUp() {
        super.setUp()

        minimumNumber = 1
        maximumNumber = 49
        count = 6
    }

    // MARK: - Tests

    func testThrowingMinimumNumberIsGreaterThanMaximumNumberError() {
        XCTAssertThrowsError(try Lottery().makeResults(minimumNumber: 60, maximumNumber: maximumNumber, count: count)) { error in
            XCTAssertEqual(error as? LotteryError, LotteryError.minimumNumberIsGreaterThanMaximumNumber)
        }
    }

    func testThrowingCountIsGreaterThanAllNumbersCountError() {
        XCTAssertThrowsError(try Lottery().makeResults(minimumNumber: minimumNumber, maximumNumber: maximumNumber, count: 50)) { error in
            XCTAssertEqual(error as? LotteryError, LotteryError.countIsGreaterThanAllNumbersCount)
        }
    }

    func testReultsAreGreaterOrEqualMinimum() {
        let results = try! Lottery().makeResults(minimumNumber: minimumNumber, maximumNumber: maximumNumber, count: count)

        for resultNumber in results {
            XCTAssertGreaterThanOrEqual(resultNumber, minimumNumber)
        }
    }

    func testReultsAreLessOrEqualMaximum() {
        let results = try! Lottery().makeResults(minimumNumber: minimumNumber, maximumNumber: maximumNumber, count: count)

        for resultNumber in results {
            XCTAssertLessThanOrEqual(resultNumber, maximumNumber)
        }
    }

    func testReultsCountAreTheSameAsUserInputCount() {
        let results = try! Lottery().makeResults(minimumNumber: minimumNumber, maximumNumber: maximumNumber, count: count)

        XCTAssertEqual(count, results.count)
    }

    func testReultsAreShuffled() {
        let basicArray = Array(minimumNumber..<minimumNumber + count)
        let results = try! Lottery().makeResults(minimumNumber: minimumNumber, maximumNumber: maximumNumber, count: count)

        XCTAssertNotEqual(basicArray, results)
    }

    func testReultsAreSorted() {
        let results = try! Lottery().makeResults(minimumNumber: minimumNumber, maximumNumber: maximumNumber, count: count)

        for index in 0..<results.count-1 {
            let resultNumber = results[index]
            let nextResultNumber = results[index + 1]

            XCTAssertGreaterThanOrEqual(nextResultNumber, resultNumber)
        }
    }

    // MARK: - All

    static var allTests = [
        ("testThrowingMinimumNumberIsGreaterThanMaximumNumberError", testThrowingMinimumNumberIsGreaterThanMaximumNumberError),
        ("testThrowingCountIsGreaterThanAllNumbersCountError", testThrowingCountIsGreaterThanAllNumbersCountError),
        ("testReultsAreGreaterOrEqualMinimum", testReultsAreGreaterOrEqualMinimum),
        ("testReultsAreLessOrEqualMaximum", testReultsAreLessOrEqualMaximum),
        ("testReultsCountAreTheSameAsUserInputCount", testReultsCountAreTheSameAsUserInputCount),
        ("testReultsAreShuffled", testReultsAreShuffled),
        ("testReultsAreSorted", testReultsAreSorted)
    ]
}
