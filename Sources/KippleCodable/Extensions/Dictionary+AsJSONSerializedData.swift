// Copyright © 2024 Brian Drelling. All rights reserved.

import Foundation

public extension Dictionary {
    /// Serializes the dictionary data to JSON and returns the resulting data.
    ///
    /// - Throws: An error of type `Error` if the serialization fails.
    /// - Returns: The JSON serialized data.
    func asJSONSerializedData() throws -> Data {
        try JSONSerialization.data(withJSONObject: self, options: .sortedKeys)
    }
}
