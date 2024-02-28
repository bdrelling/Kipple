// TODO: Write tests
public extension Int64 {
    /// Safely converts an `Int64` into an `Int32`, truncating the value if necessary.
    func safeInt32() -> Int32 {
        Int32(truncatingIfNeeded: self)
    }

    /// Safely converts a `Int64` into an `Int`, truncating the value if necessary.
    func safeInt() -> Int {
        Int(truncatingIfNeeded: self)
    }
}
