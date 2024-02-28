// Copyright © 2024 Brian Drelling. All rights reserved.

import Foundation

public extension JSONDecoder {
    /// Catches DecodingErrors and converts them into more descriptive errors before re-throwing them.
    func decodeCleaned<T>(_ type: T.Type, from data: Data) throws -> T where T: Decodable {
        do {
            return try self.decode(type, from: data)
        } catch let error as DecodingError {
            throw CleanedDecodingError(object: type, error: error)
        } catch {
            throw error
        }
    }
}

// MARK: - Supporting Types

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

    fileprivate init(objectName: String, error: DecodingError?) {
        self.objectName = objectName
        self.underlyingError = error
    }

    fileprivate init<T>(object: T.Type, error: DecodingError?) {
        self.init(objectName: String(reflecting: object), error: error)
    }
}
