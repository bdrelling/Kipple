// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "KippleCore",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
        .tvOS(.v16),
        .watchOS(.v9),
    ],
    products: [
        .library(name: "KippleCore", targets: ["KippleCore"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-kipple/Tools", .upToNextMinor(from: "0.5.0")),
    ],
    targets: [
        // Product Targets
        .target(
            name: "KippleCore",
            dependencies: []
        ),
    ]
)
