// Copyright © 2021 Brian Drelling. All rights reserved.

import Foundation

public enum KippleConstants {
    // TODO: Migrate to Kipple
    public static let defaultLaunchAnimationSpeed = 0.35

    // TODO: Migrate to Kipple
    public static let isRunningInXcodePreview: Bool = {
        #if DEBUG
            ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
        #else
            false
        #endif
    }()
}
