// Copyright © 2024 Brian Drelling. All rights reserved.

import Foundation

enum KippleCodableError: Error {
    case decodingFailure(_ message: String)
    case encodingFailure(_ message: String)
}

// MARK: - Extensions

extension KippleCodableError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case let .decodingFailure(message):
            return "A decoding failure has occurred. \(message)"
        case let .encodingFailure(message):
            return "An encoding failure has occurred. \(message)"
        }
    }
}
