// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "Lottery",
    products: [
        .library(name: "libLottery", targets: ["libLottery"]),
        .executable(name: "Lottery", targets: ["Lottery"])
    ],
    targets: [
        .target(
            name: "libLottery",
            dependencies: []),
        .target(
            name: "Lottery",
            dependencies: ["libLottery"]),
        .testTarget(
            name: "libLotteryTests",
            dependencies: ["libLottery"])
    ]
)

