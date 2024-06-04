// swift-tools-version: 5.8

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
    products: [.library(name: .kipple, targets: [.kipple])] + allModulesAsProducts,
    // Dependencies listed here should always be extremely lightweight.
    // Additionally, almost every dependency here provides a solution
    dependencies: [
        .package(url: "https://github.com/apple/swift-algorithms", from: "1.2.0"),
        .package(url: "https://github.com/apple/swift-collections", from: "1.1.0"),
        .package(url: "https://github.com/apple/swift-log", from: "1.5.4"),
        .package(url: "https://github.com/bdrelling/KippleTools", .upToNextMinor(from: "0.5.3")),
        .package(url: "https://github.com/devicekit/DeviceKit", from: "5.2.3"),
        .package(url: "https://github.com/kishikawakatsumi/KeychainAccess", from: "4.2.2"),
    ],
    targets: [
        // Umbrella Target
        // This target simply implicitly exports all modules contained within this package.
        // It should primarily be used in the prototyping stage, before reducing only to the necessary modules.
        .target(
            name: .kipple,
            dependencies: allModulesAsDependencies,
            exclude: [
                "README.md",
            ]
        ),
        // Product Targets (without Dependencies)
        .kippleTarget(name: .kippleCodable),
        .kippleTarget(name: .kippleCombine),
        .kippleTarget(name: .kippleFoundation),
        .kippleTarget(name: .kippleLocalStorage),
        // Product Targets (with Dependencies)
        .kippleTarget(
            name: .kippleCollections,
            dependencies: [
                .product(name: "Algorithms", package: "swift-algorithms"),
                .product(name: "OrderedCollections", package: "swift-collections"),
            ]
        ),
        .kippleTarget(
            name: .kippleDevice,
            dependencies: [
                .target(name: .kippleFoundation),
                .product(name: "DeviceKit", package: "DeviceKit", condition: .when(platforms: [.iOS, .tvOS, .watchOS])),
            ]
        ),
        .kippleTarget(
            name: .kippleKeychain,
            dependencies: [
                .target(name: .kippleFoundation),
                .product(name: "KeychainAccess", package: "KeychainAccess", condition: .when(platforms: [.iOS, .macOS, .tvOS, .watchOS])),
            ]
        ),
        .kippleTarget(
            name: .kippleLogging,
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
    static func kippleTarget(name: String, dependencies: [Target.Dependency] = [], resources: [Resource]? = nil) -> Target {
        .target(
            name: name,
            dependencies: dependencies,
            resources: resources,
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency"),
            ]
        )
    }
    
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
    static let kipple = "Kipple"
    static let kippleCodable = "KippleCodable"
    static let kippleCollections = "KippleCollections"
    static let kippleCombine = "KippleCombine"
    static let kippleFoundation = "KippleFoundation"
    static let kippleDevice = "KippleDevice"
    static let kippleKeychain = "KippleKeychain"
    static let kippleLocalStorage = "KippleLocalStorage"
    static let kippleLogging = "KippleLogging"
}
