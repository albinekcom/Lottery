import Foundation
import libLottery

let lottery = Lottery(minimumNumber: 1, maximumNumber: 49, count: 6)
let results = lottery.makeResults()
print(results)
