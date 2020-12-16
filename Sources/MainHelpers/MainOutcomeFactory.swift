import Application

public struct MainOutcome {

    public enum ExitType: Int32 {
        case success = 0
        case fail = -1
    }

    public let text: String
    public let exitType: ExitType

}

public struct MainOutcomeFactory {

    public init() {}

    public func makeOutcome(fromApplicationResult applicationResult: Result<[Int], ApplicationError>) -> MainOutcome {
        let text: String
        let exitType: MainOutcome.ExitType

        switch applicationResult {
            case .success(let results):
                text = "Results: \(results)"
                exitType = .success

            case .failure(let error):
                switch error {
                case .minimumNumberIsMissing:
                    text = "Error: Parameter \"Minimum number\" is missing"
                case .maximumNumberIsMissing:
                    text = "Error: Parameter \"Maximum number\" is missing"
                case .countIsMissing:
                    text = "Error: Parameter \"Count\" is missing"
                case .minimumNumberIsGreaterThanMaximumNumber:
                    text = "Error: Parameter \"Minimum number\" is greater than parameter \"Maximum number\""
                case .countIsGreaterThanAllNumbersCount:
                    text = "Error: Parameter \"Count\" is greater than all numbers count"
                }

                exitType = .fail
            }

        return MainOutcome(text: text, exitType: exitType)
    }

}
