// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

// Additional class members are defined in Kipple extensions within their respective Kipple libraries.
public enum Kipple {
    /// Whether or not this code is running within Xcode SwiftUI Previews, which has limited functionality.
    static let isRunningInXcodePreview: Bool = {
        #if DEBUG
            ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
        #else
            false
        #endif
    }()
}
