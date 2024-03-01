// Copyright © 2024 Brian Drelling. All rights reserved.

import Foundation

/// A convenience protocol for converting an object into a `URL`.
public protocol URLConvertible {
    /// Returns a `URL` representation of this object.
    func asURL() throws -> URL
}

extension URL: URLConvertible {
    public func asURL() throws -> URL {
        self
    }
}

extension String: URLConvertible {
    public func asURL() throws -> URL {
        let urlString: String
        
        #if swift(>=5.9) && !os(Linux)
        urlString = self
        #else
        urlString = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? self
        #endif
        
        if let url = URL(string: urlString) {
            return url
        } else {
            throw "Invalid URL string '\(self)'."
        }
    }
}
