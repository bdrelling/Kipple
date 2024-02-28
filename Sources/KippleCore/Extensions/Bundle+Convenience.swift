// Copyright © 2024 Brian Drelling. All rights reserved.

import Foundation

public extension Bundle {
    // MARK: Constants

    private static let errorBuildNumber = 34404

    // MARK: Properties

    /// The value for key `CFBundleName` stored in the `Info.plist`.
    var bundleName: String? {
        self.infoDictionaryString(for: .name)
    }

    /// The value for key `CFBundleDisplayName` stored in the `Info.plist`.
    var bundleDisplayName: String? {
        self.infoDictionaryString(for: .displayName)
    }

    /// The value for key `CFBundleVersion` stored in the `Info.plist`.
    var bundleBuildNumber: Int {
        guard
            let buildNumberString = self.infoDictionaryString(for: .buildNumber),
            let buildNumber = Int(buildNumberString)
        else {
            return Self.errorBuildNumber
        }

        return buildNumber
    }

    /// The value for key `CFBundleShortVersionString` stored in the `Info.plist`.
    var bundleVersion: SemanticVersion {
        guard let version = self.infoDictionaryString(for: .version) else {
            return .zero
        }

        return .from(version)
    }

    /// A custom string representation of the bundle's version and build number.
    ///
    /// Examples:
    ///   - `"v1.0.0L"` indicating a local build (if the project's build number is set to `0`),
    ///   - `"v1.2.3b100"` indicating version `1.2.3` with build number `100`.
    var bundleFullVersion: String {
        let version = self.bundleVersion.rawValue

        if self.isLocal {
            return "v\(version)L" // indicates a local build
        } else {
            return "v\(version)b\(self.bundleBuildNumber)" // indicates a hosted build
        }
    }

    /// Whether or not the `Bundle` is built locally. More specifically, whether or not it has a build number of `0`.
    ///
    /// Since we will never deploy a `Bundle` with a build number of `0`, and we will always want to rely on CI
    /// to build and deploy our apps, we can use a build number of `0` to indicate a local build.
    ///
    /// **Note: Tthis is merely a recommended convention and is not provided by the system in any way.**
    var isLocal: Bool {
        self.bundleBuildNumber == 0
    }

    // MARK: Methods

    private func infoDictionaryValue<T>(for key: String, in bundle: Bundle = .main) -> T? {
        bundle.infoDictionary?[key] as? T
    }

    private func infoDictionaryValue<T>(for key: Key, in bundle: Bundle = .main) -> T? {
        self.infoDictionaryValue(for: key.rawValue, in: bundle)
    }

    private func infoDictionaryString(for key: String, in bundle: Bundle = .main) -> String? {
        self.infoDictionaryValue(for: key, in: bundle)
    }

    private func infoDictionaryString(for key: Key, in bundle: Bundle = .main) -> String? {
        self.infoDictionaryValue(for: key, in: bundle)
    }
}

// MARK: - Supporting Types

/// Enables lookup of this file's `Bundle` with `Bundle(for: TestPlaceholder.self)` when importing this module as `@testable`.
/// Navigate to `KippleCoreTests/BundleExtensionTests` to see it in action.
public final class TestPlaceholder {}

public extension Bundle {
    struct Key: RawRepresentable {
        public let rawValue: String

        public init(rawValue: String) {
            self.rawValue = rawValue
        }
    }
}

extension Bundle.Key: ExpressibleByStringLiteral {
    public init(stringLiteral value: StringLiteralType) {
        self.init(rawValue: value)
    }
}

// MARK: - Convenience

public extension Bundle.Key {
    static let buildNumber: Self = "CFBundleVersion"
    static let displayName: Self = "CFBundleDisplayName"
    static let name: Self = "CFBundleName"
    static let version: Self = "CFBundleShortVersionString"
}
