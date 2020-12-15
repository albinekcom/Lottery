import Foundation

public enum LotteryError: Error {
    case minimumNumberIsGreaterThanMaximumNumber
    case countIsGreaterThanAllNumbersCount
}

public struct Lottery {

    public init() {}

    public func makeResults(minimumNumber: Int, maximumNumber: Int, count: Int) throws -> [Int] {
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
