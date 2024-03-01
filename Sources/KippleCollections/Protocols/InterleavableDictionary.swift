// Copyright © 2024 Brian Drelling. All rights reserved.

import OrderedCollections

/// A protocol that allows `Dictionary` and `OrderedDictionary` to use the exact same `interleaved()` function.
/// This works because `OrderedDictionary` matches `Dictionary` as much as possible.
public protocol InterleavableDictionary {
    associatedtype Key: Hashable
    associatedtype Value

    typealias Element = (key: Key, value: Value)

    @inlinable
    func map<T>(_ transform: (Element) throws -> T) rethrows -> [T]
    @inlinable
    func sorted(by areInIncreasingOrder: ((key: Key, value: Value), (key: Key, value: Value)) throws -> Bool) rethrows -> [(key: Key, value: Value)]
}

// MARK: - Extensions

extension Dictionary: InterleavableDictionary {}
extension OrderedDictionary: InterleavableDictionary {}

public extension InterleavableDictionary where Key: Comparable, Value: Collection {
    /// Returns an array of tuples containing interleaved key-value pairs from the dictionary.
    ///
    /// Each tuple in the resulting array contains a key-value pair from the dictionary, with the values of the dictionary's collection associated with each key interleaved based on their index in the collection.
    ///
    /// - Returns: An array of tuples containing interleaved key-value pairs.
    /// - Complexity: O(n log n), where n is the total number of key-value pairs in the dictionary.
    ///
    /// Example:
    ///
    /// ```swift
    /// let dictionary: [String: [Int]] = ["a": [1, 2], "b": [3, 4], "c": [5, 6]]
    /// let interleaved = dictionary.interleaved()
    ///
    /// print(interleaved)
    ///
    /// // Output:
    /// // [("a", 1), ("a", 2), ("b", 3), ("b", 4), ("c", 5), ("c", 6)]
    /// ```
    func interleaved() -> [(Key, Value.Element)] {
        let sortedKeyValuePairs = self.sorted { $0.key < $1.key }

        var interleaved: [(Key, Value.Element)] = []

        for (key, values) in sortedKeyValuePairs {
            for value in values {
                interleaved.append((key, value))
            }
        }

        return interleaved
    }
}
