// swift-tools-version:5.6

import PackageDescription

let package = Package(
    name: "Lottery",
    
    targets: [
        .executableTarget(
            name: "Lottery"
        ),
        
        .testTarget(
            name: "LotteryTests",
            dependencies: ["Lottery"]
        )
    ]
)
