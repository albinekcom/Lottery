import XCTest

import libLotteryTests
import libLotteryArgumentsParserTests

var tests = [XCTestCaseEntry]()
tests += LotteryTests.allTests()
tests += LotteryArgumentsParserTests.allTests()

XCTMain(tests)
