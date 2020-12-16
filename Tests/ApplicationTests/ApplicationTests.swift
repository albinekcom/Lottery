@testable import Application
@testable import LotteryArgumentsParser
@testable import LotteryEngine
import XCTest

final class ApplicationTests: XCTestCase { // TODO: Add unit tests here
    
    func testApplicationReturnsMinimumNumberIsMissingError() {
        let application = Application(lotteryArgumentsParser: MockLotteryArgumentsParserReturningMinimumNumberIsMissingError(), lotteryEngine: MockLotteryEnginePortReturningProperValues())
        
        let applicationResult = application.makeApplicationResult(userStringArguments: [])
        
        XCTAssertEqual(applicationResult, .failure(.minimumNumberIsMissing))
    }
    
    func testApplicationReturnsMaximumNumberIsMissingError() {
        let application = Application(lotteryArgumentsParser: MockLotteryArgumentsParserReturningMaximumNumberIsMissingError(), lotteryEngine: MockLotteryEnginePortReturningProperValues())
        
        let applicationResult = application.makeApplicationResult(userStringArguments: [])
        
        XCTAssertEqual(applicationResult, .failure(.maximumNumberIsMissing))
    }
    
    func testApplicationReturnsCountIsMissingError() {
        let application = Application(lotteryArgumentsParser: MockLotteryArgumentsParserReturningCountIsMissingError(), lotteryEngine: MockLotteryEnginePortReturningProperValues())
        
        let applicationResult = application.makeApplicationResult(userStringArguments: [])
        
        XCTAssertEqual(applicationResult, .failure(.countIsMissing))
    }
    
    func testApplicationReturnsMinimumNumberIsGreaterThanMaximumNumberError() {
        let application = Application(lotteryArgumentsParser: MockLotteryArgumentsParserReturningProperValues(), lotteryEngine: MockLotteryEnginePortReturningMinimumNumberIsGreaterThanMaximumNumberError())
        
        let applicationResult = application.makeApplicationResult(userStringArguments: [])
        
        XCTAssertEqual(applicationResult, .failure(.minimumNumberIsGreaterThanMaximumNumber))
    }
    
    func testApplicationReturnsCountIsGreaterThanAllNumbersCountError() {
        let application = Application(lotteryArgumentsParser: MockLotteryArgumentsParserReturningProperValues(), lotteryEngine: MockLotteryEnginePortReturningCountIsGreaterThanAllNumbersCountError())
        
        let applicationResult = application.makeApplicationResult(userStringArguments: [])
        
        XCTAssertEqual(applicationResult, .failure(.countIsGreaterThanAllNumbersCount))
    }
    
    func testApplicationReturnsProperResults() {
        let application = Application(lotteryArgumentsParser: MockLotteryArgumentsParserReturningProperValues(), lotteryEngine: MockLotteryEnginePortReturningProperValues())
        
        let applicationResult = application.makeApplicationResult(userStringArguments: [])
        
        XCTAssertEqual(applicationResult, .success([]))
    }

}

// MARK: - Helpers

struct MockLotteryArgumentsParserReturningProperValues: LotteryArgumentsParserPort {
    
    func parse(arguments: [String]) -> Result<LotteryArguments, LotteryArgumentsParserError> { .success(LotteryArguments(minimumNumber: 1, maximumNumber: 49, count: 6)) }
    
}

struct MockLotteryArgumentsParserReturningMinimumNumberIsMissingError: LotteryArgumentsParserPort {
    
    func parse(arguments: [String]) -> Result<LotteryArguments, LotteryArgumentsParserError> { .failure(.minimumNumberError) }
    
}

struct MockLotteryArgumentsParserReturningMaximumNumberIsMissingError: LotteryArgumentsParserPort {
    
    func parse(arguments: [String]) -> Result<LotteryArguments, LotteryArgumentsParserError> { .failure(.maximumNumberError) }
    
}

struct MockLotteryArgumentsParserReturningCountIsMissingError: LotteryArgumentsParserPort {
    
    func parse(arguments: [String]) -> Result<LotteryArguments, LotteryArgumentsParserError> { .failure(.countError) }
    
}

struct MockLotteryEnginePortReturningProperValues: LotteryEnginePort {
    
    func makeResults(minimumNumber: Int, maximumNumber: Int, count: Int) -> Result<[Int], LotteryEngineError> { .success([]) }
    
}

struct MockLotteryEnginePortReturningMinimumNumberIsGreaterThanMaximumNumberError: LotteryEnginePort {
    
    func makeResults(minimumNumber: Int, maximumNumber: Int, count: Int) -> Result<[Int], LotteryEngineError> { .failure(LotteryEngineError.minimumNumberIsGreaterThanMaximumNumber) }
    
}

struct MockLotteryEnginePortReturningCountIsGreaterThanAllNumbersCountError: LotteryEnginePort {
    
    func makeResults(minimumNumber: Int, maximumNumber: Int, count: Int) -> Result<[Int], LotteryEngineError> { .failure(LotteryEngineError.countIsGreaterThanAllNumbersCount) }
    
}

