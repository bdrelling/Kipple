// Copyright © 2024 Brian Drelling. All rights reserved.

import Foundation

public extension PropertyListDecoder {
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
