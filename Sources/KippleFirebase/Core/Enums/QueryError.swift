// Copyright © 2021 Brian Drelling. All rights reserved.

import Foundation

public enum QueryError: Error {
    case invalidDocumentID(String)
}

extension QueryError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .invalidDocumentID(id):
            return "Invalid Document ID '\(id)'."
        }
    }
}
