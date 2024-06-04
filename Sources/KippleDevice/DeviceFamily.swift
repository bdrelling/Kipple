// Copyright © 2024 Brian Drelling. All rights reserved.

/// The family (or category) a given device belongs to.
/// For non-Apple devices, a value of `"Unknown"` is returned.
public enum DeviceFamily: String, Codable, Sendable, Equatable, Hashable {
    case iPhone
    case iPod
    case iPad
    case mac = "Mac"
    case appleWatch = "Apple Watch"
    case appleTV = "Apple TV"
    case unknown = "Unknown"
}
