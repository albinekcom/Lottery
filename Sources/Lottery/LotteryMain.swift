@main
struct LotteryMain {
    
    static var printerType: Printer.Type = SystemPrinter.self
    static var arguments = CommandLine.arguments
    static var lotteryType: AnyLottery.Type = Lottery.self
    
    static func main() {
        do {
            let userArguments = try UserArguments(arguments: arguments)
            let lotteryResults = try lotteryType.results(minimumNumber: userArguments.minimumNumberValue,
                                                         maximumNumber: userArguments.maximumNumberValue,
                                                         count: userArguments.countValue)
            
            printerType.display(text: "\(lotteryResults)")
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
