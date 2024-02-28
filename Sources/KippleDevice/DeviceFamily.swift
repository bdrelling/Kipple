// Copyright © 2024 Brian Drelling. All rights reserved.

public enum DeviceFamily: String, Equatable, Hashable, Codable {
    case iPhone
    case iPod
    case iPad
    case mac = "Mac"
    case appleWatch = "Apple Watch"
    case appleTV = "Apple TV"
    case unknown = "Unknown"
}
