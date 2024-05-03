// Copyright © 2024 Brian Drelling. All rights reserved.

import Foundation

public struct CleanedDecodingError: LocalizedError {
    public let objectName: String
    public let underlyingError: DecodingError?

    public var errorDescription: String? {
        var message = "Unable to decode '\(self.objectName)'."

        if let error = self.underlyingError {
            message += " \(error.cleanedDescription)"
        }

        return message
    }

    init(objectName: String, error: DecodingError?) {
        self.objectName = objectName
        self.underlyingError = error
    }

    init<T>(object: T.Type, error: DecodingError?) {
        self.init(objectName: String(reflecting: object), error: error)
    }
}
