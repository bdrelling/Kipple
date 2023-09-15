// Copyright © 2023 Brian Drelling. All rights reserved.

import Foundation

public extension Bool {
    /// Whether or not the `DEBUG` flag is defined, which typically indicates a Debug build configuration.
    static let isDebugging: Bool = {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }()
}

#if os(iOS) || os(macOS) || os(tvOS) || os(watchOS)

public extension Bool {
    /// Whether or not this code is running within Xcode SwiftUI Previews, which has limited functionality.
    static let isRunningInXcodePreview: Bool = {
        #if DEBUG
        return ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
        #else
        return false
        #endif
    }()

    /// Whether or not the app is running on the simulator.
    static let isRunningOnSimulator: Bool = {
        #if targetEnvironment(simulator)
        true
        #else
        false
        #endif
    }()

    /// Whether or not the application is running via TestFlight.
    ///
    /// Source: [StackOverflow](https://stackoverflow.com/a/38984554)
    static let isRunningOnTestFlight: Bool = Bundle.main.appStoreReceiptURL?.path.contains("sandboxReceipt") ?? false

    /// Whether or not the currently running build is an internal build for developers, employees, and/or beta-testers.
    static var isRunningInternalBuild: Bool {
        .isDebugging || .isRunningOnSimulator || .isRunningOnTestFlight
    }
}

#endif
