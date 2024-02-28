// Copyright © 2024 Brian Drelling. All rights reserved.

import Foundation

public extension Bundle {
    // MARK: Constants

    private static let errorBuildNumber = 34404

    // MARK: Properties

    var bundleName: String? {
        self.infoString(for: .name)
    }

    var bundleDisplayName: String? {
        self.infoString(for: .displayName)
    }

    var bundleBuildNumber: Int {
        guard
            let buildNumberString = self.infoString(for: .buildNumber),
            let buildNumber = Int(buildNumberString)
        else {
            return Self.errorBuildNumber
        }

        return buildNumber
    }

    var bundleVersion: SemanticVersion {
        guard let version = self.infoString(for: .version) else {
            return .zero
        }

        return .from(version)
    }

    var bundleFullVersion: String {
        let version = self.bundleVersion.rawValue

        if self.isLocal {
            return "v\(version)L" // indicates a local build
        } else {
            return "v\(version)b\(self.bundleBuildNumber)" // indicates a hosted build
        }
    }

    var isLocal: Bool {
        self.bundleBuildNumber == 0
    }

    // MARK: Methods

    private func infoValue<T>(for key: String, in bundle: Bundle = .main) -> T? {
        bundle.infoDictionary?[key] as? T
    }

    private func infoValue<T>(for key: Key, in bundle: Bundle = .main) -> T? {
        self.infoValue(for: key.rawValue, in: bundle)
    }

    private func infoString(for key: String, in bundle: Bundle = .main) -> String? {
        self.infoValue(for: key, in: bundle)
    }

    private func infoString(for key: Key, in bundle: Bundle = .main) -> String? {
        self.infoString(for: key.rawValue, in: bundle)
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
