enum LotteryError: Error, CustomStringConvertible {

    case minimumNumberIsGreaterThanMaximumNumber
    case countIsGreaterThanAllNumbersCount
    
    var description: String {
        switch self {
        case .minimumNumberIsGreaterThanMaximumNumber:
            return "Argument \"Minimum number\" is greater than argument \"Maximum number\""
        case .countIsGreaterThanAllNumbersCount:
            return "Argument \"Count\" is greater than all numbers count"
        }
    }

}

protocol AnyLottery {
    
    static func results(minimumNumber: Int, maximumNumber: Int, count: Int) throws -> [Int]
    
}

struct Lottery: AnyLottery {
    
    static func results(minimumNumber: Int, maximumNumber: Int, count: Int) throws -> [Int] {
        guard minimumNumber <= maximumNumber else {
            throw LotteryError.minimumNumberIsGreaterThanMaximumNumber
        }

        let allNumbers = Array(minimumNumber...maximumNumber)

        guard count <= allNumbers.count else {
            throw LotteryError.countIsGreaterThanAllNumbersCount
        }

        return allNumbers.shuffled()[..<count].sorted()
    }
    
}
