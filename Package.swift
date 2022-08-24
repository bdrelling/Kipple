// swift-tools-version:5.3

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
    targets: [
        // Product Targets
        .target(
            name: "KippleCore",
            dependencies: []
        ),
    ]
)

#if swift(>=5.5)
// Add Kipple Tools if possible.
package.dependencies.append(
    .package(url: "https://github.com/swift-kipple/Tools", from: "0.2.5")
)
#endif
