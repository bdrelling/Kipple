// Copyright © 2024 Brian Drelling. All rights reserved.

public extension Array where Element: Hashable {
    /// Removes duplicate elements from this array without converting it into a `Set`, thereby maintaining its sort order.
    func removeDuplicates() -> Self {
        var seen = Set<Element>()
        var result = [Element]()

        for value in self {
            if !seen.contains(value) {
                seen.insert(value)
                result.append(value)
            }
        }

        return result
    }
}
