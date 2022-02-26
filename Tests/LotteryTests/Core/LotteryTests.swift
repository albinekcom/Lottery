import XCTest
@testable import Lottery

final class LotteryTests: XCTestCase {
    
    private let defaultMinimumNumber = 1
    private let defaultMaximumNumber = 49
    private let defaultCount = 6
    
    // MARK: - Tests

    func test_results_throwsMinimumNumberIsGreaterThanMaximumNumberError() {
        var thrownError: Error?
        
        XCTAssertThrowsError(try Lottery.results(minimumNumber: 60, maximumNumber: defaultMaximumNumber, count: defaultCount)) {
            thrownError = $0
        }
        
        XCTAssertEqual(thrownError as! LotteryError, .minimumNumberIsGreaterThanMaximumNumber)
    }
    
    func test_results_throwsCountIsGreaterThanAllNumbersCountError() {
        var thrownError: Error?
        
        XCTAssertThrowsError(try Lottery.results(minimumNumber: defaultMinimumNumber, maximumNumber: defaultMaximumNumber, count: 50)) {
            thrownError = $0
        }
        
        XCTAssertEqual(thrownError as! LotteryError, .countIsGreaterThanAllNumbersCount)
    }
    
    func test_results_areGreaterOrEqualMinimum() {
        let results = try! Lottery.results(minimumNumber: defaultMinimumNumber, maximumNumber: defaultMaximumNumber, count: defaultCount)
        
        results.forEach { XCTAssertGreaterThanOrEqual($0, defaultMinimumNumber) }
    }
    
    func test_results_areLessOrEqualMaximum() {
        let results = try! Lottery.results(minimumNumber: defaultMinimumNumber, maximumNumber: defaultMaximumNumber, count: defaultCount)
        
        results.forEach { XCTAssertLessThanOrEqual($0, defaultMaximumNumber) }
    }
    
    func test_reults_countAreTheSameAsProvided() {
        let results = try! Lottery.results(minimumNumber: defaultMinimumNumber, maximumNumber: defaultMaximumNumber, count: defaultCount)

        XCTAssertEqual(results.count, defaultCount)
    }
    
    func test_results_areShuffled() {
        let basicArray = Array(defaultMinimumNumber..<defaultMaximumNumber + defaultCount)
        let results = try! Lottery.results(minimumNumber: defaultMinimumNumber, maximumNumber: defaultMaximumNumber, count: defaultCount)

        XCTAssertNotEqual(basicArray, results)
    }
    
    func test_reults_areSorted() {
        let results = try! Lottery.results(minimumNumber: defaultMinimumNumber, maximumNumber: defaultMaximumNumber, count: defaultCount)
        
        for index in 0..<results.count-1 {
            let resultNumber = results[index]
            let nextResultNumber = results[index + 1]

            XCTAssertGreaterThanOrEqual(nextResultNumber, resultNumber)
        }
    }
    
    func test_lotteryErrors_description() {
        XCTAssertEqual("Argument \"Minimum number\" is greater than argument \"Maximum number\"",
                       LotteryError.minimumNumberIsGreaterThanMaximumNumber.description)
        XCTAssertEqual("Argument \"Count\" is greater than all numbers count",
                       LotteryError.countIsGreaterThanAllNumbersCount.description)
    }
    
}
