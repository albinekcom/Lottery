public enum LotteryEngineError: Error {

    case minimumNumberIsGreaterThanMaximumNumber
    case countIsGreaterThanAllNumbersCount

}

public struct LotteryEngine {

    public init() {}

}

extension LotteryEngine: LotteryEnginePort {

    public func makeResults(minimumNumber: Int, maximumNumber: Int, count: Int) -> Result<[Int], LotteryEngineError> {
        guard minimumNumber <= maximumNumber else {
            return .failure(.minimumNumberIsGreaterThanMaximumNumber)
        }

        let allNumbers = Array(minimumNumber...maximumNumber)

        guard count <= allNumbers.count else {
            return .failure(.countIsGreaterThanAllNumbersCount)
        }

        let results = allNumbers.shuffled()[..<count].sorted()

        return .success(results)
    }

}

public protocol LotteryEnginePort {

    func makeResults(minimumNumber: Int, maximumNumber: Int, count: Int) -> Result<[Int], LotteryEngineError>

}
