// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

public extension Bundle {
    // MARK: Enums

    enum Key: String {
        // Apple
        case buildNumber = "CFBundleVersion"
        case displayName = "CFBundleDisplayName"
        case name = "CFBundleName"
        case version = "CFBundleShortVersionString"
        // Custom
        case sentryDSN = "SentryPublicDSN"
    }

    // MARK: Constants

    private static let errorVersionString = "vERR"
    private static let errorBuildNumber = 0

    // MARK: Properties

    var bundleName: String? {
        self.infoString(for: .name)
    }

    var bundleDisplayName: String? {
        self.infoString(for: .displayName)
    }

    var bundleBuildNumber: Int {
        guard let buildNumberString = self.infoString(for: .buildNumber) else {
            return Self.errorBuildNumber
        }

        return Int(buildNumberString) ?? Self.errorBuildNumber
    }

    var bundleVersion: SemanticVersion {
        guard let version = self.infoString(for: .version) else {
            return .zero
        }

        return .from(version)
    }

    var bundleFullVersion: String {
        guard let version = self.infoString(for: .version) else {
            return Self.errorVersionString
        }

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
        bundle.infoDictionary?[key] as? String
    }

    private func infoString(for key: Key, in bundle: Bundle = .main) -> String? {
        self.infoString(for: key.rawValue, in: bundle)
    }
}
