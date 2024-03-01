// Copyright © 2024 Brian Drelling. All rights reserved.

public extension BinaryInteger {
    /// Safely converts a `UInt64` into an `Int64`, truncating the value if necessary.
    func clampedInt64() -> Int64 {
        .init(clamping: self)
    }

    /// Safely converts an `Int64` into an `Int32`, truncating the value if necessary.
    func clampedInt32() -> Int32 {
        .init(clamping: self)
    }

    /// Safely converts a `Int64` into an `Int`, truncating the value if necessary.
    func clampedInt() -> Int {
        .init(clamping: self)
    }
}
