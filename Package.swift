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
        .library(name: "KippleCombine", targets: ["KippleCombine"]),
        .library(name: "KippleCore", targets: ["KippleCore"]),
        .library(name: "KippleDevice", targets: ["KippleDevice"]),
        .library(name: "KippleStorage", targets: ["KippleStorage"]),
    ],
    dependencies: [
        .package(url: "https://github.com/devicekit/DeviceKit", from: "5.2.2"),
        .package(url: "https://github.com/swift-kipple/Tools", .upToNextMinor(from: "0.5.0")),
    ],
    targets: [
        // Product Targets
        .target(
            name: "KippleCombine"
        ),
        .target(
            name: "KippleCore"
        ),
        .target(
            name: "KippleDevice",
            dependencies: [
                .target(name: "KippleCore"),
                .product(name: "DeviceKit", package: "DeviceKit", condition: .when(platforms: [.iOS, .tvOS, .watchOS])),
            ]
        ),
        .target(
            name: "KippleStorage"
        ),
        // Test Targets
        .testTarget(
            name: "KippleCombineTests",
            dependencies: [
                .target(name: "KippleCombine"),
            ]
        ),
        .testTarget(
            name: "KippleCoreTests",
            dependencies: [
                .target(name: "KippleCore"),
            ]
        ),
        .testTarget(
            name: "KippleDeviceTests",
            dependencies: [
                .target(name: "KippleDevice"),
            ]
        ),
        .testTarget(
            name: "KippleStorageTests",
            dependencies: [
                .target(name: "KippleStorage"),
            ]
        ),
    ]
)
