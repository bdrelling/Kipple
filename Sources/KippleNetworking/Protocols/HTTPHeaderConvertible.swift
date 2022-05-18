// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

/// A convenience protocol for converting an object into an HTTP header string.
public protocol HTTPHeaderConvertible: Hashable {
    /// Returns a `String` representation of this object.
    var rawValue: String { get }
}

extension String: HTTPHeaderConvertible {
    public var rawValue: String {
        return self
    }
}

extension HTTPHeader: HTTPHeaderConvertible {}
