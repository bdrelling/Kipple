// Copyright © 2024 Brian Drelling. All rights reserved.

import Foundation

/// A representation of information typically required by an application.
///
/// Unlike `BundleInfo` and `DeviceInfo`, this `struct` is entirely custom and has no "`current`" representation,
/// meaning a consumer should implement their own extension of it like so:
///
/// ```swift
/// public extension AppInfo {
///     static let current: Self = .init(
///         bundle: .main, // the default value
///         appStoreTeamID: "AB12CD34EF"
///     )
/// }
/// ```
public struct AppInfo {
    // MARK: Properties

    /// The unique identifier for the app.
    ///
    /// For Apple applications, this should typically match the value defined by the `CFBundleIdentifier` key in the bundle's `Info.plist`.
    public let identifier: String

    /// The display name of the app.
    ///
    /// For Apple applications, this should typically match the value defined by the `CFBundleDisplayName` key in the bundle's `Info.plist`.
    public let name: String

    /// The identifier of the App Store Team that builds and distributes this application.
    ///
    /// For help finding your App Store Team ID, see [here](https://developer.apple.com/help/account/manage-your-team/locate-your-team-id/).
    public let appStoreTeamID: String

    /// The version of the app.
    ///
    /// For Apple applications, this should typically match the value defined by the `CFBundleShortVersionString` key in the bundle's `Info.plist`.
    public let version: SemanticVersion

    /// The build numer of the app.
    ///
    /// For Apple applications, this should typically match the value defined by the `CFBundleVersion` key in the bundle's `Info.plist`.
    public let buildNumber: Int

    /// A Keychain Access Group identifier following the format of `<TeamID>.<BundleIdentifier>`.
    public var defaultKeychainAccessGroup: String {
        "\(self.appStoreTeamID).\(self.identifier)"
    }

    // MARK: Initializers

    public init(
        identifier: String,
        name: String,
        version: SemanticVersion,
        buildNumber: Int,
        appStoreTeamID: String
    ) {
        self.identifier = identifier
        self.name = name
        self.version = version
        self.buildNumber = buildNumber
        self.appStoreTeamID = appStoreTeamID
    }

    public init(
        bundle: Bundle = .main,
        appStoreTeamID: String
    ) {
        self.init(
            identifier: bundle.bundleIdentifier ?? "Unknown",
            name: bundle.bundleDisplayName ?? bundle.bundleName ?? "Unknown",
            version: bundle.bundleVersion,
            buildNumber: bundle.bundleBuildNumber,
            appStoreTeamID: appStoreTeamID
        )
    }
}
