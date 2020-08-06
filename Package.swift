// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "Kipple",
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
