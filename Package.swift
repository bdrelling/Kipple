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
        .package(url: "https://github.com/swift-kipple/Tools", revision: "4bc0d4cee521e5a7389d832b8fac45cdf4a867f2"),
    ],
    targets: [
        // Product Targets
        .target(
            name: "KippleCore",
            dependencies: []
        ),
    ]
)
