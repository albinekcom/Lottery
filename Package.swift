// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "Lottery",

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
