import Foundation

public struct Lottery {
    
    public let minimumNumber: Int
    public let maximumNumber: Int
    public let count: Int
    
    public init(minimumNumber: Int, maximumNumber: Int, count: Int) {
        self.minimumNumber = minimumNumber
        self.maximumNumber = maximumNumber
        self.count = count
    }
    
    public func makeResults() -> [Int] {
        return Array(minimumNumber...maximumNumber).shuffled()[..<count].sorted()
    }
    
}
