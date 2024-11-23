// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SeatMap",
    defaultLocalization: "en",
    platforms: [.iOS(.v16)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SeatMap",
            targets: ["SeatMap"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Kajalluthra/Networking.git", from: "1.0.0"),
        .package(url: "https://github.com/Kajalluthra/Account.git", from: "1.0.0"),
        .package(url: "https://github.com/Kajalluthra/LoggerExtension.git",  from: "3.0.0"),
        .package(url: "https://github.com/Kajalluthra/TestUtils.git", from: "2.0.0"),
        .package(url: "https://github.com/Kajalluthra/Core.git", from: "1.0.0"),
        .package(url: "https://github.com/Kajalluthra/UIComponents.git", from: "3.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SeatMap",
            dependencies: ["Networking", "LoggerExtension", "Core", "UIComponents", "Account"],
            resources: [.process("Resources")]),
        .testTarget(
            name: "SeatMapTests",
            dependencies: ["SeatMap", "TestUtils"],
            resources: [
                .process("json")
            ])
    ]
)
