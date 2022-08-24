// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

// Additional class members are defined in Kipple extensions within their respective Kipple libraries.
public enum Kipple {
    /// Whether or not this code is running within Xcode SwiftUI Previews, which has limited functionality.
    public static let isRunningInXcodePreview: Bool = {
        #if DEBUG
        return ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
        #else
        return false
        #endif
    }()

    /// Whether or not the application is running via TestFlight.
    ///
    /// Source: [StackOverflow](https://stackoverflow.com/a/38984554)
    public static let isRunningOnTestFlight: Bool = Bundle.main.appStoreReceiptURL?.path.contains("sandboxReceipt") ?? false

    /// Whether or not the application is running on the simulator.
    ///
    /// Source: [StackOverflow](https://stackoverflow.com/a/38984554)
    public static let isRunningOnSimulator: Bool = Bundle.main.appStoreReceiptURL?.path.contains("CoreSimulator") ?? false
}
