// Copyright © 2024 Brian Drelling. All rights reserved.

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

    /// Whether or not the currently running build is a private build intended for personal use, development, and/or beta testing.
    static let isRunningPrivateBuild: Bool = .isDebugging || .isRunningOnSimulator || .isRunningOnTestFlight
    
    // MARK: Testing
    
    /// Whether or not the app is running unit tests.
    /// **On Linux, this is always `false` due to limitations with the `swift test` command.**
    ///
    /// To manually set this value, you can pass in the `-unit_testing` argument or
    /// set the `IS_RUNNING_UNIT_TESTS`environment variable to `true`.
    static let isRunningUnitTests: Bool = {
        // NSClassFromString has limitations on non-Apple platforms due to the lack of an Obj-C runtime.
        NSClassFromString("XCTestCase") != nil ||
        // Similarly, XCTestConfigurationFilePath doesn't appear to be set when running "swift test", only "xcodebuild test".
        ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil ||
        // Therefore, we also need a manual argument option until this is resolved
        // and we have a reliable cross-platform method of detecting unit testing.
        ProcessInfo.processInfo.arguments.contains("-unit_testing") ||
        // And for good measure, we include an Environment Variable, too.
        ProcessInfo.processInfo.environment["IS_RUNNING_UNIT_TESTS"] == "true"
    }()

    /// Whether or not the app is running UI tests.
    ///
    /// To manually set this value, you can pass in the `-ui_testing` argument or
    /// set the `IS_RUNNING_UI_TESTS`environment variable to `true`.
    static let isRunningUITests: Bool = {
        ProcessInfo.processInfo.arguments.contains("-ui_testing") ||
        ProcessInfo.processInfo.environment["IS_RUNNING_UI_TESTS"] == "true"
    }()
    
    /// Whether or not the app is running unit or UI tests.
    ///
    /// On non-Apple environments, this property is simply an alias for `isRunningUnitTests`.
    static let isRunningTests: Bool = .isRunningUnitTests || .isRunningUITests
    
    /// Whether or not the application should mock external services, from networking to hardware operations.
    /// This is used primarily for testing and Xcode Previews in order to improve performance.
    static let shouldMockExternalServices: Bool = .isRunningTests || .isRunningInXcodePreview
}
