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
        .library(name: "Kipple", targets: ["Kipple"]),
    ],
    dependencies: [],
    targets: [
        // Product Targets
        .target(
            name: "Kipple",
            dependencies: []
        ),
    ]
)
