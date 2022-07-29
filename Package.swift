// swift-tools-version:5.6

import PackageDescription

let package = Package(
    name: "KippleCore",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6),
    ],
    products: [
        .library(name: "KippleCore", targets: ["KippleCore"]),
    ],
    dependencies: [
        // Development
        .package(url: "https://github.com/swift-kipple/Tools", from: "0.2.1"),
    ],
    targets: [
        // Product Targets
        .target(
            name: "KippleCore",
            dependencies: []
        ),
    ]
)
