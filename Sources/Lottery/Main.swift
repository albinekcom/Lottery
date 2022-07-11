@main
struct Main {
    
    static var printer: Printer = SystemPrinter()
    static var lottery: AnyLottery = Lottery()
    static var arguments: [String] = CommandLine.arguments
    
    static func main() throws {
        let userArguments = try UserArguments(arguments: arguments)
        
        let lotteryResults = try lottery.results(
            minimumNumber: userArguments.minimumNumberValue,
            maximumNumber: userArguments.maximumNumberValue,
            count: userArguments.countValue
        )
        
        printer.display(text: "\(lotteryResults)")
    }
    
}

private struct SystemPrinter: Printer {
    
    func display(text: String) { print(text) }
    
}
