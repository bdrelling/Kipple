// Copyright © 2024 Brian Drelling. All rights reserved.

/// A modulo function for Swift that accounts for negative numbers, which allows for a negative remainder.
///
/// Swift's implementation of `%` is known as the **Remainder Operator**,
/// and only accounts for finding the remainder between two positive numbers.
///
/// **References:**
///   - [Basic Operators -- Apple Documentation](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/basicoperators/#Remainder-Operator)
///   - [Swift mod operator (%) -- Sarunw](https://sarunw.com/posts/swift-mod/)
public func modulo<T: BinaryInteger>(_ dividend: T, _ divisor: T) -> T {
    // Check for division by zero
    guard divisor != 0 else {
        // Return zero if divisor is zero
        return 0
    }

    let remainder = dividend % divisor
    return remainder >= 0 ? remainder : remainder + divisor
}
