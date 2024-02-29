// Copyright © 2024 Brian Drelling. All rights reserved.

public extension Int {
    /// Whether or not this value is even (eg. a multiple of `2`).
    var isEven: Bool {
        self.isMultiple(of: 2)
    }
}
