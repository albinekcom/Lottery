import Foundation

enum UserArgumentsError: Error, CustomStringConvertible {
    
    case minimumNumberError
    case maximumNumberError
    case countError
    
    var description: String {
        switch self {
        case .minimumNumberError:
            return "Argument \"Minimum number\" is missing"
        case .maximumNumberError:
            return "Argument \"Maximum number\" is missing"
        case .countError:
            return "Argument \"Count\" is missing"
        }
    }
    
}

enum UserArgumentType: String {
    
    case minimumNumber
    case maximumNumber
    case count
    
}

struct UserArguments {
    
    let minimumNumberValue: Int
    let maximumNumberValue: Int
    let countValue: Int
    
    init(arguments: [String] = CommandLine.arguments) throws {
        var foundMinimumNumberValue: Int?
        var foudMaximumNumberValue: Int?
        var foundCountValue: Int?
        
        for index in 0..<arguments.count - 1 {
            let argument = arguments[index]
            
            guard let userArgumentType = UserArgumentType(rawValue: String(argument.dropFirst().dropFirst())),
                  let value = Int(arguments[index + 1]) else { continue }
            
            switch userArgumentType {
            case .minimumNumber:
                foundMinimumNumberValue = value
            case .maximumNumber:
                foudMaximumNumberValue = value
            case .count:
                foundCountValue = value
            }
        }

        guard let foundMinimumNumberValue = foundMinimumNumberValue else {
            throw UserArgumentsError.minimumNumberError
        }

        guard let foudMaximumNumberValue = foudMaximumNumberValue else {
            throw UserArgumentsError.maximumNumberError
        }

        guard let foundCountValue = foundCountValue else {
            throw UserArgumentsError.countError
        }
        
        minimumNumberValue = foundMinimumNumberValue
        maximumNumberValue = foudMaximumNumberValue
        countValue = foundCountValue
    }
    
}
