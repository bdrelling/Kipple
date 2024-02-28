// Copyright © 2024 Brian Drelling. All rights reserved.

import Foundation
import KippleCore

public struct DeviceInfo: Equatable, Hashable, Codable {
    // MARK: Properties

    /// The version of `Bundle.main` running on the device.
    public let bundleVersion: SemanticVersion

    /// The build number of `Bundle.main` running on the device.
    public let bundleBuildNumber: Int

    /// The family of the device (eg. "iPhone", "Apple TV").
    public let deviceFamily: DeviceFamily

    /// The model of the device (eg. "iPhone" or "iPod Touch").
    public let deviceModel: String

    /// The name of the operating system running on the device (eg. "iOS" or "tvOS").
    public let systemName: String

    /// The version of the operating system running on the device (eg. 10.5.1).
    public let systemVersion: SemanticVersion

    // MARK: Initializers

    public init(
        bundleVersion: SemanticVersion,
        bundleBuildNumber: Int,
        deviceFamily: DeviceFamily,
        deviceModel: String,
        systemName: String,
        systemVersion: SemanticVersion
    ) {
        self.bundleVersion = bundleVersion
        self.bundleBuildNumber = bundleBuildNumber
        self.deviceFamily = deviceFamily
        self.deviceModel = deviceModel
        self.systemName = systemName
        self.systemVersion = systemVersion
    }
}

// MARK: - Convenience

#if canImport(UIKit) && canImport(DeviceKit)

@_implementationOnly import DeviceKit
import UIKit

#endif

/// Information for a particular device (eg. iPhone, Apple TV).
public extension DeviceInfo {
    /// Information for the currently running device.
    static let current: Self = .init(
        bundleVersion: Bundle.main.bundleVersion,
        bundleBuildNumber: Bundle.main.bundleBuildNumber,
        deviceFamily: Self.currentDeviceFamily,
        deviceModel: Self.currentDeviceModel,
        systemName: Self.currentSystemName,
        systemVersion: Self.currentSystemVersion
    )

    /// The family of the device (eg. "iPhone", "Apple TV").
    private static var currentDeviceFamily: DeviceFamily {
        #if os(iOS)
        if Device.current.isPhone {
            return .iPhone
        } else if Device.current.isPad {
            return .iPad
        } else if Device.current.isPod {
            return .iPod
        } else {
            return .unknown
        }
        #elseif os(watchOS)
        return .appleWatch
        #elseif os(tvOS)
        return .appleTV
        #elseif os(macOS)
        return .mac
        #else
        return .unknown
        #endif
    }

    /// The model of the device (eg. "iPhone" or "iPod Touch").
    private static var currentDeviceModel: String {
        #if canImport(UIKit)
        Device.current.model ?? "Unknown"
        #elseif os(macOS)
        "Mac"
        #else
        "Unknown"
        #endif
    }

    /// The name of the operating system running on the device (eg. "iOS" or "tvOS").
    private static var currentSystemName: String {
        #if canImport(UIKit)
        Device.current.systemName ?? "Unknown"
        #elseif os(macOS)
        "macOS"
        #elseif os(Linux)
        "Linux"
        #else
        "Unknown"
        #endif
    }

    /// The version of the operating system running on the device (eg. 10.5.1).
    private static var currentSystemVersion: SemanticVersion {
        #if canImport(UIKit)
        .from(Device.current.systemVersion ?? "Unknown")
        #elseif os(macOS) || os(Linux)
        ProcessInfo.processInfo.operatingSystemVersion.semanticVersion
        #else
        "Unknown"
        #endif
    }
}

extension OperatingSystemVersion {
    var semanticVersion: SemanticVersion {
        .init(
            major: self.majorVersion,
            minor: self.minorVersion,
            patch: self.patchVersion
        )
    }
}
