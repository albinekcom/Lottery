public enum LotteryArgumentsParserError: Error {
    
    case minimumNumberError
    case maximumNumberError
    case countError
    
}

public struct LotteryArguments: Equatable {
    
    public let minimumNumber: Int
    public let maximumNumber: Int
    public let count: Int
    
}

public struct LotteryArgumentsParser {
    
    public init() {}
    
}

extension LotteryArgumentsParser: LotteryArgumentsParserPort {
    
    public func parse(arguments: [String]) -> Result<LotteryArguments, LotteryArgumentsParserError> {
        let dictionary = convertArgumentsToDictionary(arguments: arguments)
        
        guard let minimumNumberValue = dictionary["minimumNumber"] else {
            return .failure(.minimumNumberError)
        }
        
        guard let maximumNumberValue = dictionary["maximumNumber"] else {
            return .failure(.maximumNumberError)
        }
        
        guard let countValue = dictionary["count"] else {
            return .failure(.countError)
        }
        
        return .success(LotteryArguments(minimumNumber: minimumNumberValue, maximumNumber: maximumNumberValue, count: countValue))
    }
    
    private func convertArgumentsToDictionary(arguments: [String]) -> [String: Int] {
        var dictionary = [String: Int]()
        
        for index in 0..<arguments.count {
            let argument = arguments[index]
            
            guard argument.count > 2 else {
                continue
            }
            
            let firstTwoCharactersOfArgument = argument[..<argument.index(argument.startIndex, offsetBy: 2)]
            let nextIndex = index + 1
            
            if firstTwoCharactersOfArgument == "--", nextIndex < arguments.count {
                let key = String(argument.dropFirst().dropFirst())
                let value = Int(arguments[nextIndex])
                
                dictionary[key] = value
            }
        }
        
        return dictionary
    }
    
}

public protocol LotteryArgumentsParserPort {
    
    func parse(arguments: [String]) -> Result<LotteryArguments, LotteryArgumentsParserError>
    
}

