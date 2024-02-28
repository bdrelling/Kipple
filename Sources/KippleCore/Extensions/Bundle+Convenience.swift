// Copyright © 2024 Brian Drelling. All rights reserved.

import Foundation

public extension Bundle {
    // MARK: Constants

    /// A build number that cannot be published or deployed to the App Store or TestFlight,
    /// which can safely signal that an error has occurred when attempting to read information
    /// from the `Bundle`.
    private static let errorBuildNumber = -1

    // MARK: Properties

    /// The name of the bundle, defined by the `CFBundleName` key in the bundle's `Info.plist`.
    ///
    /// If the key is not defined, the value `"Unknown"` is returned. This is because a `Bundle`
    /// being accessed this way will very rarely _not_ have a `CFBundleName`, so this allows us
    /// to use a non-optional `String` as the value type for ease of use.
    var bundleName: String? {
        self.infoDictionaryString(for: .name)
    }
    
    /// The display name of the bundle, defined by the `CFBundleDisplayName` key in the bundle's `Info.plist`.
    ///
    /// This is the value that is typically displayed below an iOS application's icon.
    var bundleDisplayName: String? {
        self.infoDictionaryString(for: .displayName)
    }

    /// The version of the bundle, defined by the `CFBundleShortVersionString` key in the bundle's `Info.plist`.
    var bundleVersion: SemanticVersion {
        guard let version = self.infoDictionaryString(for: .version) else {
            return .zero
        }

        return .from(version)
    }
    
    /// The build number of the bundle, defined by the `CFBundleVersion` key in the bundle's `Info.plist`.
    var bundleBuildNumber: Int {
        guard
            let buildNumberString = self.infoDictionaryString(for: .buildNumber),
            let buildNumber = Int(buildNumberString)
        else {
            return Self.errorBuildNumber
        }

        return buildNumber
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

    /// Returns a generic value from this `Bundle`'s `Info.plist`.
    func infoDictionaryValue<T>(for key: String, in bundle: Bundle = .main) -> T? {
        bundle.infoDictionary?[key] as? T
    }

    /// Returns a `String` value from this `Bundle`'s `Info.plist`.
    func infoDictionaryString(for key: String, in bundle: Bundle = .main) -> String? {
        self.infoDictionaryValue(for: key, in: bundle)
    }
}
