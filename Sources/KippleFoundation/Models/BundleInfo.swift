// Copyright © 2024 Brian Drelling. All rights reserved.

import Foundation

/// A representation of common information typically found within a `Bundle`.
///
/// The information included in this `struct` is _not_ exhaustive, only the most commonly referenced keys are included.
/// For more `Bundle` information, access the `Bundle.infoDictionary` property directly.
public struct BundleInfo {
    // MARK: Properties

    /// The identifier of the bundle, defined by the `CFBundleIdentifier` key in the bundle's `Info.plist`.
    public let identifier: String

    /// The name of the bundle, defined by the `CFBundleName` key in the bundle's `Info.plist`.
    public let name: String?

    /// The display name of the bundle, defined by the `CFBundleDisplayName` key in the bundle's `Info.plist`.
    public let displayName: String?

    /// The version of the bundle, defined by the `CFBundleShortVersionString` key in the bundle's `Info.plist`.
    public let version: SemanticVersion

    /// The build number of the bundle, defined by the `CFBundleVersion` key in the bundle's `Info.plist`.
    public let buildNumber: Int

    /// A custom string representation of the bundle's version and build number.
    ///
    /// Examples:
    ///   - `"v1.0.0L"` indicating a local build (if the project's build number is set to `0`),
    ///   - `"v1.2.3b100"` indicating version `1.2.3` with build number `100`.
    public var fullVersion: String

    // MARK: Initializers

    public init(
        identifier: String,
        name: String,
        displayName: String?,
        version: SemanticVersion,
        buildNumber: Int,
        fullVersion: String? = nil
    ) {
        self.identifier = identifier
        self.name = name
        self.displayName = displayName
        self.version = version
        self.buildNumber = buildNumber
        self.fullVersion = fullVersion ?? "v\(version)b\(buildNumber)"
    }

    public init(bundle: Bundle) {
        self.init(
            identifier: bundle.bundleIdentifier ?? "Unknown",
            name: bundle.bundleName ?? "Unknown",
            displayName: bundle.bundleDisplayName,
            version: bundle.bundleVersion,
            buildNumber: bundle.bundleBuildNumber,
            fullVersion: bundle.bundleFullVersion
        )
    }
}

// MARK: - Convenience

public extension BundleInfo {
    /// Information for the currently running `Bundle` (eg. `Bundle.main`).
    static let current: Self = .init(bundle: .main)
}
