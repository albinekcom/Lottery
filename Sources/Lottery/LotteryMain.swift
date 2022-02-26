@main
struct LotteryMain {
    
    static var printerType: Printer.Type = SystemPrinter.self
    
    static func main() {
        do {
            let userArguments = try UserArguments(arguments: CommandLine.arguments)
            let lotteryResults = try Lottery.results(minimumNumber: userArguments.minimumNumberValue,
                                                     maximumNumber: userArguments.maximumNumberValue,
                                                     count: userArguments.countValue)
            
            printerType.display(text: lotteryResults.description)
        } catch let error as CustomStringConvertible {
            printerType.display(text: "Error: \(error)")
        } catch {
            printerType.display(text: "Error: something went wrong")
        }
    }
    
}

protocol Printer {
    
    static func display(text: String)
    
}

private struct SystemPrinter: Printer {
    
    static func display(text: String) { print(text) }
    
}

// TODO: Add unit tests for "Lottery"
// TODO: Add unit tests for "UserArguments"
// TODO: Add unit tests for "LotteryMain"
