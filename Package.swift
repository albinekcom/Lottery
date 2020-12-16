// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "Lottery",

    dependencies: [],

    targets: [
        .target(
            name: "LotteryArgumentsParser",
            dependencies: []),
        .target(
            name: "LotteryEngine",
            dependencies: []),
        .target(
            name: "Application",
            dependencies: ["LotteryArgumentsParser", "LotteryEngine"]),
        .target(
            name: "MainHelpers",
            dependencies: ["Application"]),
        .target(
            name: "Lottery",
            dependencies: ["Application", "MainHelpers"]),

        .testTarget(
            name: "LotteryArgumentsParserTests",
            dependencies: ["LotteryArgumentsParser"]),
        .testTarget(
            name: "LotteryEngineTests",
            dependencies: ["LotteryEngine"]),
        .testTarget(
            name: "ApplicationTests",
            dependencies: ["Application", "LotteryArgumentsParser", "LotteryEngine"]),
        .testTarget(
            name: "MainHelpersTests",
            dependencies: ["MainHelpers"]),

    ]
)
