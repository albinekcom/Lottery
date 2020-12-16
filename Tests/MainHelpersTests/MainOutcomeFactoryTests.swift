@testable import Application
@testable import MainHelpers
import XCTest

final class MainOutcomeFactoryTests: XCTestCase { // TODO: Add unit tests here

    func testOutcomeForApplicationProperResult() {
        let outcome = MainOutcomeFactory().makeOutcome(fromApplicationResult: .success([]))
        
        XCTAssertEqual(outcome.text, "Results: []")
        XCTAssertEqual(outcome.exitType, .success)
    }
    
    func testOutcomeForApplicationResultWithMinimumNumberIsMissingError() {
        let outcome = MainOutcomeFactory().makeOutcome(fromApplicationResult: .failure(.minimumNumberIsMissing))
        
        XCTAssertEqual(outcome.text, "Error: Parameter \"Minimum number\" is missing")
        XCTAssertEqual(outcome.exitType, .fail)
    }
    
    func testOutcomeForApplicationResultWithMaximumNumberIsMissingError() {
        let outcome = MainOutcomeFactory().makeOutcome(fromApplicationResult: .failure(.maximumNumberIsMissing))
        
        XCTAssertEqual(outcome.text, "Error: Parameter \"Maximum number\" is missing")
        XCTAssertEqual(outcome.exitType, .fail)
    }
    
    func testOutcomeForApplicationResultWithCountIsMissingError() {
        let outcome = MainOutcomeFactory().makeOutcome(fromApplicationResult: .failure(.countIsMissing))
        
        XCTAssertEqual(outcome.text, "Error: Parameter \"Count\" is missing")
        XCTAssertEqual(outcome.exitType, .fail)
    }
    
    func testOutcomeForApplicationResultWithMinimumNumberIsGreaterThanMaximumNumberError() {
        let outcome = MainOutcomeFactory().makeOutcome(fromApplicationResult: .failure(.minimumNumberIsGreaterThanMaximumNumber))
        
        XCTAssertEqual(outcome.text, "Error: Parameter \"Minimum number\" is greater than parameter \"Maximum number\"")
        XCTAssertEqual(outcome.exitType, .fail)
    }
    
    func testOutcomeForApplicationResultWithCountIsGreaterThanAllNumbersCountError() {
        let outcome = MainOutcomeFactory().makeOutcome(fromApplicationResult: .failure(.countIsGreaterThanAllNumbersCount))
        
        XCTAssertEqual(outcome.text, "Error: Parameter \"Count\" is greater than all numbers count")
        XCTAssertEqual(outcome.exitType, .fail)
    }

}
