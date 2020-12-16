@testable import LotteryEngine
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
        
        switch results {
        case .success(let results):
            for resultNumber in results {
                XCTAssertGreaterThanOrEqual(resultNumber, defaultMinimumNumber)
            }
        case.failure(_):
            XCTFail()
        }
    }
    
    func testReultsAreLessOrEqualMaximum() {
        let results = LotteryEngine().makeResults(minimumNumber: defaultMinimumNumber, maximumNumber: defaultMaximumNumber, count: defaultCount)
        
        switch results {
        case .success(let results):
            for resultNumber in results {
                XCTAssertLessThanOrEqual(resultNumber, defaultMaximumNumber)
            }
        case.failure(_):
            XCTFail()
        }
    }
    
    func testReultsCountAreTheSameAsUserInputCount() {
        let results = LotteryEngine().makeResults(minimumNumber: defaultMinimumNumber, maximumNumber: defaultMaximumNumber, count: defaultCount)
        
        switch results {
        case .success(let results):
            XCTAssertEqual(results.count, defaultCount)
        case.failure(_):
            XCTFail()
        }
    }
    
    func testReultsAreShuffled() {
        let basicArray = Array(defaultMinimumNumber..<defaultMaximumNumber + defaultCount)
        let results = LotteryEngine().makeResults(minimumNumber: defaultMinimumNumber, maximumNumber: defaultMaximumNumber, count: defaultCount)
        
        switch results {
        case .success(let results):
            XCTAssertNotEqual(results, basicArray)
        case.failure(_):
            XCTFail()
        }
    }
    
    func testReultsAreSorted() {
        let results = LotteryEngine().makeResults(minimumNumber: defaultMinimumNumber, maximumNumber: defaultMaximumNumber, count: defaultCount)
        
        switch results {
        case .success(let results):
            for index in 0..<results.count-1 {
                let resultNumber = results[index]
                let nextResultNumber = results[index + 1]

                XCTAssertGreaterThanOrEqual(nextResultNumber, resultNumber)
            }
        case.failure(_):
            XCTFail()
        }
    }

}
