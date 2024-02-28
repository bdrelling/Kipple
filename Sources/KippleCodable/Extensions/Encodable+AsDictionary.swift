// Copyright © 2024 Brian Drelling. All rights reserved.

import Foundation

// TODO: Can this be optimized somehow? Can it re-use the existing Data+PrettyPrint stuff or w/e?
public extension Encodable {
    func asDictionary(encoder: JSONEncoder) throws -> [String: Any]? {
        let data = try encoder.encode(self)

        return try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
    }
}
