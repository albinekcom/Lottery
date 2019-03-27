// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "Lottery",
    products: [
        .library(name: "libLottery", targets: ["libLottery"]),
        .library(name: "libLotteryArgumentsParser", targets: ["libLotteryArgumentsParser"]),
        .executable(name: "Lottery", targets: ["Lottery"])
    ],
    targets: [
        .target(
            name: "libLottery",
            dependencies: []),
        .target(
            name: "libLotteryArgumentsParser",
            dependencies: []),
        .target(
            name: "Lottery",
            dependencies: ["libLottery", "libLotteryArgumentsParser"]),
        .testTarget(
            name: "libLotteryArgumentsParserTests",
            dependencies: ["libLotteryArgumentsParser"]),
        .testTarget(
            name: "libLotteryTests",
            dependencies: ["libLottery"])
    ]
)
