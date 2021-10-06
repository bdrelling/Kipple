// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Kipple",
    platforms: [
        .iOS(.v14),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6),
    ],
    products: [
        .library(name: "Kipple", targets: ["KippleCore", "KippleUI"]),
        .library(name: "KippleAuth", targets: ["KippleAuth"]),
        .library(name: "KippleCore", targets: ["KippleCore"]),
        .library(name: "KippleErrorHandling", targets: ["KippleErrorHandling"]),
        .library(name: "KippleFirebase", targets: ["KippleFirebase"]),
        .library(name: "KippleTesting", targets: ["KippleTesting"]),
        .library(name: "KippleUI", targets: ["KippleUI"]),
    ],
    dependencies: [
        .package(name: "BetterCodable", url: "https://github.com/marksands/BetterCodable", .upToNextMinor(from: "0.4.0")),
        .package(name: "Firebase", url: "https://github.com/firebase/firebase-ios-sdk", .upToNextMajor(from: "8.7.0")),
        .package(name: "Sentry", url: "https://github.com/getsentry/sentry-cocoa", .upToNextMajor(from: "7.4.2")),
        .package(name: "UIDeviceComplete", url: "https://github.com/Nirma/UIDeviceComplete", .upToNextMajor(from: "2.7.6"))
    ],
    targets: [
        // Product Targets
        .target(
            name: "KippleCore",
            dependencies: [
                .product(name: "UIDeviceComplete", package: "UIDeviceComplete"),
            ]
        ),
        .target(
            name: "KippleAuth",
            dependencies: [
                .target(name: "KippleErrorHandling"),
                .target(name: "KippleFirebase"),
            ]
        ),
        .target(
            name: "KippleErrorHandling",
            dependencies: [
                .product(name: "Sentry", package: "Sentry"),
            ]
        ),
        .target(
            name: "KippleFirebase",
            dependencies: [
                .product(name: "BetterCodable", package: "BetterCodable"),
                .product(name: "FirebaseAuth", package: "Firebase"),
                .product(name: "FirebaseFirestore", package: "Firebase"),
                .product(name: "FirebaseFirestoreSwift-Beta", package: "Firebase"),
                .target(name: "KippleErrorHandling"),
            ]
        ),
        .target(
            name: "KippleTesting",
            dependencies: [
                .target(name: "KippleAuth"),
                .target(name: "KippleFirebase"),
                .product(name: "FirebaseFirestore", package: "Firebase"),
            ]
        ),
        .target(
            name: "KippleUI",
            dependencies: [
                .target(name: "KippleCore"),
            ]
        ),
        // Test Targets
        .testTarget(
            name: "KippleAuthTests",
            dependencies: [
                .target(name: "KippleAuth"),
                .target(name: "KippleTesting"),
            ]
        ),
        .testTarget(
            name: "KippleFirebaseTests",
            dependencies: [
                .target(name: "KippleFirebase"),
            ]
        )
    ]
)
