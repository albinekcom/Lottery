import Foundation
import LotteryCore

let applicationResult = Application().makeApplicationResult(userStringArguments: CommandLine.arguments)
let mainOutcome = MainOutcomeFactory().makeOutcome(fromApplicationResult: applicationResult)

print(mainOutcome.text)
exit(mainOutcome.exitType.rawValue)
