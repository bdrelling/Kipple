// Copyright © 2024 Brian Drelling. All rights reserved.

import Foundation

public extension Encodable {
    /// Converts the encodable object into a dictionary representation.
    ///
    /// - Parameter encoder: The JSON encoder used to encode the object into JSON data.
    /// - Returns: A dictionary representation of the encodable object, or `nil` if the encoding fails.
    /// - Throws: An error if the encoding process fails.
    func asDictionary(encoder: JSONEncoder) throws -> [String: Any]? {
        // Encode the object into JSON data using the provided encoder.
        let data = try encoder.encode(self)

        // Convert the JSON data into a dictionary.
        return try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
    }
}
