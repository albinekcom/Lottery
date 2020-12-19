// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "Lottery",

    targets: [
        .target(
            name: "LotteryCore"),

        .target(
            name: "Lottery",
            dependencies: ["LotteryCore"]),

        .testTarget(
            name: "LotteryCoreTests",
            dependencies: ["LotteryCore"])
    ]
)
