// Copyright © 2024 Brian Drelling. All rights reserved.

import Foundation

/// Extensions for `String` providing convenience methods for common operations.
public extension String {
    /// Replaces tab characters with spaces in the string.
    ///
    /// - Parameter count: The number of spaces to replace each tab with. Defaults to 4.
    /// - Returns: A new string with tabs replaced by spaces.
    func replacingTabsWithSpaces(_ count: Int = 4) -> String {
        self.replacingOccurrences(of: "\t", with: String(repeating: " ", count: count))
    }

    /// Trims leading and trailing slashes from the string.
    ///
    /// - Returns: A new string with leading and trailing slashes removed.
    func trimmingSlashes() -> String {
        self.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
    }

    /// Encodes the string as base64.
    ///
    /// - Returns: A base64-encoded representation of the string, or `nil` if encoding fails.
    func base64Encoded() -> String? {
        let data = self.data(using: .utf8)
        return data?.base64EncodedString()
    }
}
