// swift-tools-version:5.6

import PackageDescription

let package = Package(
    name: "Kipple",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .tvOS(.v15),
        .watchOS(.v8),
    ],
    products: [
        .library(name: "Kipple", targets: ["KippleCore", "KippleUI"]),
        .library(name: "KippleCore", targets: ["KippleCore"]),
        .library(name: "KippleDevice", targets: ["KippleDevice"]),
//        .library(name: "KippleDiagnostics", targets: ["KippleDiagnostics"]),
        .library(name: "KippleTesting", targets: ["KippleTesting"]),
        .library(name: "KippleUI", targets: ["KippleUI", "SafeNavigationKit"]),
        .library(name: "SafeNavigationKit", targets: ["SafeNavigationKit"]),
    ],
    dependencies: [
//        .package(url: "https://github.com/marksands/BetterCodable", .upToNextMinor(from: "0.4.0")),
//        .package(url: "https://github.com/kean/Pulse", .upToNextMinor(from: "0.18.0")),
//        .package(url: "https://github.com/getsentry/sentry-cocoa", .upToNextMajor(from: "7.4.2")),
        .package(url: "https://github.com/Nirma/UIDeviceComplete", .upToNextMajor(from: "2.8.1")),
        // Development
        .package(url: "https://github.com/nicklockwood/SwiftFormat", from: "0.49.11"),
        .package(url: "https://github.com/Realm/SwiftLint", from: "0.47.1"),
    ],
    targets: [
        // Product Targets
        .target(
            name: "KippleCore",
            dependencies: []
        ),
        .target(
            name: "KippleDevice",
            dependencies: [
                .target(name: "KippleCore"),
                .product(name: "UIDeviceComplete", package: "UIDeviceComplete", condition: .when(platforms: [.iOS])),
            ]
        ),
//        .target(
//            name: "KippleDiagnostics",
//            dependencies: [
//                .product(name: "Pulse", package: "Pulse"),
//                .product(name: "Sentry", package: "Sentry"),
//            ]
//        ),
        .target(
            name: "KippleTesting",
            dependencies: []
        ),
        .target(
            name: "KippleUI",
            dependencies: [
                .target(name: "KippleCore"),
            ]
        ),
        .target(
            name: "SafeNavigationKit",
            dependencies: []
        ),
        // Plugins
        .plugin(
            name: "Reformat",
            capability: .command(
                intent: .sourceCodeFormatting(),
                permissions: [
                    .writeToPackageDirectory(reason: "Format source code in Swift files"),
                ]
            ),
            dependencies: [
                .product(name: "swiftformat", package: "SwiftFormat"),
            ]
        ),
    ]
)
