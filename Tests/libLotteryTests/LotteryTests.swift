@testable import libLottery
import XCTest

final class LotteryTests: XCTestCase {
    
    private var lottery: Lottery!
    
    private var minimumNumber: Int!
    private var maximumNumber: Int!
    private var count: Int!
    
    // MARK: - Setting
    
    override func setUp() {
        super.setUp()
        
        minimumNumber = 1
        maximumNumber = 49
        count = 6
        
        lottery = Lottery(minimumNumber: minimumNumber, maximumNumber: maximumNumber, count: count)
    }
    
    // MARK: - Tests
    
    func testReultsAreGreaterOrEqualMinimum() {
        for resultNumber in lottery.makeResults() {
            XCTAssertGreaterThanOrEqual(resultNumber, minimumNumber)
        }
    }
    
    func testReultsAreLessOrEqualMaximum() {
        for resultNumber in lottery.makeResults() {
            XCTAssertLessThanOrEqual(resultNumber, maximumNumber)
        }
    }
    
    func testReultsCountAreTheSameAsUserInputCount() {
        XCTAssertEqual(count, lottery.makeResults().count)
    }
    
    func testReultsAreShuffled() {
        let basicArray = Array(minimumNumber...count)
        let results = lottery.makeResults()
        
        XCTAssertTrue(basicArray != results)
    }
    
    func testReultsAreSorted() {
        let results = lottery.makeResults()
        
        for index in 0..<results.count-1 {
            let resultNumber = results[index]
            let nextResultNumber = results[index + 1]
            
            XCTAssertGreaterThanOrEqual(nextResultNumber, resultNumber)
        }
    }
    
    // MARK: - All
    
    static var allTests = [
        ("testReultsAreGreaterOrEqualMinimum", testReultsAreGreaterOrEqualMinimum),
        ("testReultsAreLessOrEqualMaximum", testReultsAreLessOrEqualMaximum),
        ("testReultsCountAreTheSameAsUserInputCount", testReultsCountAreTheSameAsUserInputCount),
        ("testReultsAreShuffled", testReultsAreShuffled),
        ("testReultsAreSorted", testReultsAreSorted)
    ]
}
