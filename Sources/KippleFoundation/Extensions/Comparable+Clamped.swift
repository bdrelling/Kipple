// Copyright © 2024 Brian Drelling. All rights reserved.

import Foundation

public extension Comparable {
    /// Clamps this value between a minimum and maximum value.
    ///
    /// If less than the minimum, the minimum is returned.
    /// If greater than the maximum, the maximum is returned.
    func clamped(min: Self, max: Self) -> Self {
        if self < min {
            return min
        } else if self > max {
            return max
        } else {
            return self
        }
    }

    /// Clamps this value between the lower and upper bound of a closed range.
    ///
    /// If less than the lower bound, the lower bound is returned.
    /// If greater than the upper bound, the upper bound is returned.
    func clamped(to range: ClosedRange<Self>) -> Self {
        self.clamped(min: range.lowerBound, max: range.upperBound)
    }
}
