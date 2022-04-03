// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Kipple",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
        .tvOS(.v13),
        .watchOS(.v6),
    ],
    products: [
        .library(name: "Kipple", targets: ["KippleCore", "KippleUI"]),
        .library(name: "KippleCore", targets: ["KippleCore"]),
        .library(name: "KippleDevice", targets: ["KippleDevice"]),
//        .library(name: "KippleDiagnostics", targets: ["KippleDiagnostics"]),
        .library(name: "KippleTesting", targets: ["KippleTesting"]),
        .library(name: "KippleUI", targets: ["KippleUI"]),
    ],
    dependencies: [
//        .package(name: "Pulse", url: "https://github.com/kean/Pulse", .upToNextMinor(from: "0.18.0")),
//        .package(name: "Sentry", url: "https://github.com/getsentry/sentry-cocoa", .upToNextMajor(from: "7.4.2")),
        .package(name: "UIDeviceComplete", url: "https://github.com/Nirma/UIDeviceComplete", .upToNextMajor(from: "2.8.1")),
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
    ]
)
