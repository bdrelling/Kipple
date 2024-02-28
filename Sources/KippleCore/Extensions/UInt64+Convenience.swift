// Copyright © 2024 Brian Drelling. All rights reserved.

// TODO: Write tests
public extension UInt64 {
    /// Safely converts a `UInt64` into an `Int64`, truncating the value if necessary.
    func safeInt64() -> Int64 {
        Int64(truncatingIfNeeded: self)
    }

    /// Safely converts a `UInt64` into an `Int32`, truncating the value if necessary.
    func safeInt32() -> Int32 {
        Int32(truncatingIfNeeded: self)
    }

    /// Safely converts a `UInt64` into an `Int`, truncating the value if necessary.
    func safeInt() -> Int {
        Int(truncatingIfNeeded: self)
    }
}
