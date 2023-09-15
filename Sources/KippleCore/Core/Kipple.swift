// Copyright © 2023 Brian Drelling. All rights reserved.

#if os(iOS) || os(macOS) || os(tvOS) || os(watchOS)

// Additional class members are defined in Kipple extensions within their respective Kipple libraries.
@available(*, deprecated, message: "Use Bool+Convenience extensions instead.")
public enum Kipple {
    /// Whether or not this code is running within Xcode SwiftUI Previews, which has limited functionality.
    public static let isRunningInXcodePreview: Bool = .isRunningInXcodePreview

    /// Whether or not the application is running via TestFlight.
    ///
    /// Source: [StackOverflow](https://stackoverflow.com/a/38984554)
    public static let isRunningOnTestFlight: Bool = .isRunningOnTestFlight

    /// Whether or not the application is running on the simulator.
    ///
    /// Source: [StackOverflow](https://stackoverflow.com/a/38984554)
    public static let isRunningOnSimulator: Bool = .isRunningOnSimulator
}

#endif
