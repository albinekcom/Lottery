import Foundation
import libLottery
import libLotteryArgumentsParser

let minimumNumber: Int
let maximumNumber: Int
let count: Int

do {
    (minimumNumber, maximumNumber, count) = try LotteryArgumentsParser.parse(arguments: CommandLine.arguments)
} catch LotteryArgumentsParserError.minimumNumberIsMissing {
    print("Error: Mimimum number is missing")
    exit(1)
} catch LotteryArgumentsParserError.maximumNumberIsMissing {
    print("Error: Maximum number is missing")
    exit(1)
} catch LotteryArgumentsParserError.countIsMissing {
    print("Error: Count is missing")
    exit(1)
}

let results: [Int]

do {
    results = try Lottery().makeResults(minimumNumber: minimumNumber, maximumNumber: maximumNumber, count: count)
} catch LotteryError.minimumNumberIsGreaterThanMaximumNumber {
    print("Error: Mimimum number is bigger then maximum number")
    exit(1)
}  catch LotteryError.countIsGreaterThanAllNumbersCount {
    print("Error: Count is bigger than all numbers count")
    exit(1)
}

print("Results: \(results)")
