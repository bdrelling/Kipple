// Copyright © 2021 Brian Drelling. All rights reserved.

import Foundation

public extension DecodingError {
    var cleanedDescription: String {
        switch self {
        case let .typeMismatch(type, context):
            return "Type mismatch for key '\(context.codingPath.jsonPath)'. Expected type '\(String(describing: type))'."
        case let .valueNotFound(type, context):
            return "Value not found for key '\(context.codingPath.jsonPath)' of type '\(String(describing: type))'."
        case let .keyNotFound(key, context):
            var allKeys = context.codingPath
            allKeys.append(key)

            return "Key '\(allKeys.jsonPath)' not found."
        case let .dataCorrupted(context) where context.codingPath.isEmpty:
            return "Data corrupted."
        case let .dataCorrupted(context):
            return "Data corrupted at key '\(context.codingPath.jsonPath)'."
        @unknown default:
            return self.localizedDescription
        }
    }
}

private extension Array where Element == CodingKey {
    var jsonPath: String {
        var path = ""

        for key in self {
            if let index = key.intValue {
                path += "[\(index)]"
            } else {
                path += ".\(key.stringValue)"
            }
        }

        return path.trimmingCharacters(in: CharacterSet(charactersIn: "."))
    }
}
