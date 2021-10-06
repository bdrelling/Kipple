// Copyright © 2021 Brian Drelling. All rights reserved.

import Foundation

public struct GenericError: Error {
    public let message: String

    public init(_ message: String) {
        self.message = message
    }

    public init(message: String) {
        self.message = message
    }
}

// MARK: - Extensions

extension GenericError: LocalizedError {
    public var errorDescription: String? {
        self.message
    }
}
