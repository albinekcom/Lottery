import XCTest
@testable import Lottery

final class UserArgumentsTests: XCTestCase {
    
    // MARK: - Tests
    
    func test_init_throwsMinimumNumberError() {
        var thrownError: Error?
        
        XCTAssertThrowsError(try UserArguments(arguments: ["--maximumNumber", "49", "--count", "6"])) {
            thrownError = $0
        }
        
        XCTAssertEqual(thrownError as! UserArgumentsError, .minimumNumberError)
     }
    
    func test_init_throwsMaximumNumberError() {
        var thrownError: Error?
        
        XCTAssertThrowsError(try UserArguments(arguments: ["--minimumNumber", "1", "--count", "6"])) {
            thrownError = $0
        }
        
        XCTAssertEqual(thrownError as! UserArgumentsError, .maximumNumberError)
     }
    
    func test_init_throwsCountError() {
        var thrownError: Error?
        
        XCTAssertThrowsError(try UserArguments(arguments: ["--minimumNumber", "1", "--maximumNumber", "49"])) {
            thrownError = $0
        }
        
        XCTAssertEqual(thrownError as! UserArgumentsError, .countError)
     }
    
     func test_init_fromStandardArgumentsOrder() {
         let userArguments = try! UserArguments(arguments: ["--minimumNumber", "1", "--maximumNumber", "49", "--count", "6"])

         XCTAssertEqual(1, userArguments.minimumNumberValue)
         XCTAssertEqual(49, userArguments.maximumNumberValue)
         XCTAssertEqual(6, userArguments.countValue)
     }
    
    func test_init_fromDifferentArgumentsOrder() {
        let userArguments = try! UserArguments(arguments: ["--count", "6", "--maximumNumber", "49", "--minimumNumber", "1"])

        XCTAssertEqual(1, userArguments.minimumNumberValue)
        XCTAssertEqual(49, userArguments.maximumNumberValue)
        XCTAssertEqual(6, userArguments.countValue)
    }
    
    func test_init_throwsMinimumNumberErrorWhenValueIsMissing() {
        var thrownError: Error?
        
        XCTAssertThrowsError(try UserArguments(arguments: ["--minimumNumber", "--maximumNumber", "49", "--count", "6"])) {
            thrownError = $0
        }
        
        XCTAssertEqual(thrownError as! UserArgumentsError, .minimumNumberError)
    }
    
    func test_init_throwsMaximumNumberErrorWhenValueIsMissing() {
        var thrownError: Error?
        
        XCTAssertThrowsError(try UserArguments(arguments: ["--minimumNumber", "1", "--maximumNumber", "--count", "6"])) {
            thrownError = $0
        }
        
        XCTAssertEqual(thrownError as! UserArgumentsError, .maximumNumberError)
    }
    
    func test_init_throwsCountErrorWhenValueIsMissing() {
        var thrownError: Error?
        
        XCTAssertThrowsError(try UserArguments(arguments: ["--minimumNumber", "1", "--maximumNumber", "49", "--count"])) {
            thrownError = $0
        }
        
        XCTAssertEqual(thrownError as! UserArgumentsError, .countError)
    }

     func test_init_throwsMinimumNumberErrorWhenNotANumberProvided() {
         var thrownError: Error?
         
         XCTAssertThrowsError(try UserArguments(arguments: ["--minimumNumber", "a"])) {
             thrownError = $0
         }
         
         XCTAssertEqual(thrownError as! UserArgumentsError, .minimumNumberError)
     }
    
    func test_userArgumentsError_description() {
        XCTAssertEqual("Argument \"Minimum number\" is missing",
                       UserArgumentsError.minimumNumberError.description)
        XCTAssertEqual("Argument \"Maximum number\" is missing",
                       UserArgumentsError.maximumNumberError.description)
        XCTAssertEqual("Argument \"Count\" is missing",
                       UserArgumentsError.countError.description)
    }
    
}
