// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "Kipple",
    platforms: [
        .iOS(.v13),         // SwiftUI support
        .macOS(.v10_15),    // SwiftUI support
        .tvOS(.v13),        // SwiftUI support
        .watchOS(.v6),      // SwiftUI support
    ],
    products: [
        .library(name: "Kipple", targets: ["KippleCore", "KippleUI"]),
        .library(name: "KippleCore", targets: ["KippleCore"]),
        .library(name: "KippleUI", targets: ["KippleUI"]),
        // KippleFirebase is excluded from the Kipple umbrella library.
        .library(name: "KippleFirebase", targets: ["KippleFirebase"]),
    ],
    dependencies: [
        .package(name: "BetterCodable", url: "https://github.com/marksands/BetterCodable", .upToNextMinor(from: "0.3.0")),
        .package(name: "Firebase", url: "https://github.com/firebase/firebase-ios-sdk", .upToNextMajor(from: "8.0.0")),
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
            name: "KippleFirebase",
            dependencies: [
                .product(name: "BetterCodable", package: "BetterCodable"),
                .product(name: "FirebaseAuth", package: "Firebase"),
                .product(name: "FirebaseFirestore", package: "Firebase"),
                .product(name: "FirebaseFirestoreSwift-Beta", package: "Firebase"),
            ]
        ),
        .target(
            name: "KippleUI",
            dependencies: []
        ),
    ]
)
