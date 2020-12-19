@testable import LotteryCore
import XCTest

final class LotteryEngineTests: XCTestCase {

    private let defaultMinimumNumber = 1
    private let defaultMaximumNumber = 49
    private let defaultCount = 6

    func testReturningMinimumNumberIsGreaterThanMaximumNumberError() {
        let result = LotteryEngine().makeResults(minimumNumber: 60, maximumNumber: defaultMaximumNumber, count: defaultCount)

        XCTAssertEqual(result, .failure(.minimumNumberIsGreaterThanMaximumNumber))
    }

    func testReturningCountIsGreaterThanAllNumbersCountError() {
        let result = LotteryEngine().makeResults(minimumNumber: defaultMinimumNumber, maximumNumber: defaultMaximumNumber, count: 50)

        XCTAssertEqual(result, .failure(.countIsGreaterThanAllNumbersCount))
    }

    func testReultsAreGreaterOrEqualMinimum() {
        let results = LotteryEngine().makeResults(minimumNumber: defaultMinimumNumber, maximumNumber: defaultMaximumNumber, count: defaultCount)
        
        try! results.get().forEach { XCTAssertGreaterThanOrEqual($0, defaultMinimumNumber) }
    }

    func testReultsAreLessOrEqualMaximum() {
        let results = LotteryEngine().makeResults(minimumNumber: defaultMinimumNumber, maximumNumber: defaultMaximumNumber, count: defaultCount)
        
        try! results.get().forEach { XCTAssertLessThanOrEqual($0, defaultMaximumNumber) }
    }

    func testReultsCountAreTheSameAsUserInputCount() {
        let results = LotteryEngine().makeResults(minimumNumber: defaultMinimumNumber, maximumNumber: defaultMaximumNumber, count: defaultCount)
        
        let resultsArray = try! results.get()
        
        XCTAssertEqual(resultsArray.count, defaultCount)
    }

    func testReultsAreShuffled() {
        let basicArray = Array(defaultMinimumNumber..<defaultMaximumNumber + defaultCount)
        let results = LotteryEngine().makeResults(minimumNumber: defaultMinimumNumber, maximumNumber: defaultMaximumNumber, count: defaultCount)
        
        let resultsArray = try! results.get()
        
        XCTAssertNotEqual(resultsArray, basicArray)
    }

    func testReultsAreSorted() {
        let results = LotteryEngine().makeResults(minimumNumber: defaultMinimumNumber, maximumNumber: defaultMaximumNumber, count: defaultCount)
        
        let resultsArray = try! results.get()
        
        for index in 0..<resultsArray.count-1 {
            let resultNumber = resultsArray[index]
            let nextResultNumber = resultsArray[index + 1]

            XCTAssertGreaterThanOrEqual(nextResultNumber, resultNumber)
        }
    }

}
