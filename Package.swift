// swift-tools-version: 5.7

import PackageDescription

// MARK: - Convenience

let allModules: [String] = [
    .kippleCodable,
    .kippleCollections,
    .kippleCombine,
    .kippleFoundation,
    .kippleDevice,
    .kippleKeychain,
    .kippleLocalStorage,
    .kippleLogging,
]

let allModulesAsProducts = allModules.map { Product.library(name: $0, targets: [$0]) }
let allModulesAsDependencies = allModules.map(Target.Dependency.init)

// MARK: - Package Definition

let package = Package(
    name: "Kipple",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
        .tvOS(.v16),
        .watchOS(.v9),
    ],
    // Our products will always be an umbrella module ("Kipple") as well as a product for every module.
    products: [.library(name: "Kipple", targets: ["Kipple"])] + allModulesAsProducts,
    // Dependencies listed here should always be extremely lightweight.
    // Additionally, almost every dependency here provides a solution
    dependencies: [
        .package(url: "https://github.com/apple/swift-collections", .upToNextMajor(from: "1.0.4")),
        .package(url: "https://github.com/apple/swift-log", from: "1.5.4"),
        .package(url: "https://github.com/bdrelling/KippleTools", .upToNextMinor(from: "0.5.0")),
        .package(url: "https://github.com/devicekit/DeviceKit", .upToNextMajor(from: "5.2.2")),
        .package(url: "https://github.com/kishikawakatsumi/KeychainAccess", .upToNextMajor(from: "4.2.2")),
    ],
    targets: [
        // Umbrella Target
        // This target simply implicitly exports all modules contained within this package.
        // It should primarily be used in the prototyping stage, before reducing only to the necessary modules.
        .target(
            name: "Kipple",
            dependencies: allModulesAsDependencies
        ),
        // Product Targets (without Dependencies)
        .target(name: .kippleCodable),
        .target(name: .kippleCombine),
        .target(name: .kippleFoundation),
        .target(name: .kippleLocalStorage),
        // Product Targets (with Dependencies)
        .target(
            name: "KippleCollections",
            dependencies: [
                .product(name: "OrderedCollections", package: "swift-collections"),
            ]
        ),
        .target(
            name: "KippleDevice",
            dependencies: [
                .target(name: "KippleFoundation"),
                .product(name: "DeviceKit", package: "DeviceKit", condition: .when(platforms: [.iOS, .tvOS, .watchOS])),
            ]
        ),
        .target(
            name: "KippleKeychain",
            dependencies: [
                .target(name: "KippleFoundation"),
                .product(name: "KeychainAccess", package: "KeychainAccess", condition: .when(platforms: [.iOS, .macOS, .tvOS, .watchOS])),
            ]
        ),
        .target(
            name: "KippleLogging",
            dependencies: [
                .product(name: "Logging", package: "swift-log", condition: .when(platforms: [.linux])),
            ]
        ),
        // Test Targets
        .kippleTestTarget(name: .kippleCodable),
        .kippleTestTarget(name: .kippleCollections),
        .kippleTestTarget(name: .kippleCombine),
        .kippleTestTarget(name: .kippleFoundation),
        .kippleTestTarget(name: .kippleDevice),
        .kippleTestTarget(name: .kippleLocalStorage),
        .kippleTestTarget(name: .kippleLogging),
    ]
)

// MARK: - Extensions

extension Target {
    static func kippleTestTarget(name: String) -> Target {
        .testTarget(
            name: "\(name)Tests",
            dependencies: [
                .target(name: name),
            ]
        )
    }
}

// MARK: - Constants

/// Defined `String` constants representing each of our modules
extension String {
    static let kippleCodable = "KippleCodable"
    static let kippleCollections = "KippleCollections"
    static let kippleCombine = "KippleCombine"
    static let kippleFoundation = "KippleFoundation"
    static let kippleDevice = "KippleDevice"
    static let kippleKeychain = "KippleKeychain"
    static let kippleLocalStorage = "KippleLocalStorage"
    static let kippleLogging = "KippleLogging"
}
