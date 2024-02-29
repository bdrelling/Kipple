// Copyright © 2024 Brian Drelling. All rights reserved.

import Foundation

/// Extension that allows a normal `String` to be returned as an error,
/// using itself as the localized error description.
extension String: LocalizedError {
    public var errorDescription: String? {
        self
    }
}
