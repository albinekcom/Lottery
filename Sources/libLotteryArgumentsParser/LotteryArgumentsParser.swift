import Foundation

public enum LotteryArgumentsParserError: Error {
    case minimumNumberIsMissing
    case maximumNumberIsMissing
    case countIsMissing
}

public struct LotteryArgumentsParser {
    
    public static func parse(arguments: [String]) throws -> (Int, Int, Int) {
        let dictionary = convertArgumentsToDictionary(arguments: arguments)
        
        guard let minimumNumberValue = dictionary["minimumNumber"] else {
            throw LotteryArgumentsParserError.minimumNumberIsMissing
        }
        
        guard let maximumNumberValue = dictionary["maximumNumber"] else {
            throw LotteryArgumentsParserError.maximumNumberIsMissing
        }
        
        guard let countValue = dictionary["count"] else {
            throw LotteryArgumentsParserError.countIsMissing
        }
        
        return (minimumNumberValue, maximumNumberValue, countValue)
    }
    
    private static func convertArgumentsToDictionary(arguments: [String]) -> [String: Int] {
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
