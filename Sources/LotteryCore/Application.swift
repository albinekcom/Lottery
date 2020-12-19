public enum ApplicationError: Error, Equatable {

    case minimumNumberIsMissing
    case maximumNumberIsMissing
    case countIsMissing
    case minimumNumberIsGreaterThanMaximumNumber
    case countIsGreaterThanAllNumbersCount

}

public struct Application {

    private let lotteryArgumentsParser: LotteryArgumentsParserPort
    private let lotteryEngine: LotteryEnginePort

    public init(lotteryArgumentsParser: LotteryArgumentsParserPort = LotteryArgumentsParser(),
                lotteryEngine: LotteryEnginePort = LotteryEngine()) {
        self.lotteryArgumentsParser = lotteryArgumentsParser
        self.lotteryEngine = lotteryEngine
    }

}

extension Application: ApplicationPort {

    public func makeApplicationResult(userStringArguments: [String]) -> Result<[Int], ApplicationError> {
        let argumentsParserResults = lotteryArgumentsParser.parse(arguments: userStringArguments)

        let arguments: LotteryArguments

        switch argumentsParserResults {
        case .success(let parsedArguments):
            arguments = parsedArguments
        case .failure(.minimumNumberError):
            return .failure(.minimumNumberIsMissing)
        case .failure(.maximumNumberError):
            return .failure(.maximumNumberIsMissing)
        case .failure(.countError):
            return .failure(.countIsMissing)
        }

        let lotteryResults = lotteryEngine.makeResults(minimumNumber: arguments.minimumNumber, maximumNumber: arguments.maximumNumber, count: arguments.count)

        switch lotteryResults {
        case .success(let results):
            return .success(results)
        case .failure(.minimumNumberIsGreaterThanMaximumNumber):
            return .failure(.minimumNumberIsGreaterThanMaximumNumber)
        case .failure(.countIsGreaterThanAllNumbersCount):
            return .failure(.countIsGreaterThanAllNumbersCount)
        }
    }

}

public protocol ApplicationPort {

    func makeApplicationResult(userStringArguments: [String]) -> Result<[Int], ApplicationError>

}
