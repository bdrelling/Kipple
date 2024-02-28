// Copyright © 2024 Brian Drelling. All rights reserved.

public extension BidirectionalCollection where Iterator.Element: Equatable {
    /// Returns the element before the provided value.
    ///
    /// If the provided value is the first index, this function returns `nil` unless `loop` is `true`,
    /// in which case the value at the last index is returned.
    func before(_ item: Element, loop: Bool = false) -> Element? {
        guard let itemIndex = firstIndex(of: item) else { return nil }
        if itemIndex != startIndex {
            return self[index(before: itemIndex)]
        } else if loop {
            return last
        } else {
            return nil
        }
    }

    /// Returns the element after the provided value.
    ///
    /// If the provided value is the last index, this function returns `nil` unless `loop` is `true`,
    /// in which case the value at the first index is returned.
    func after(_ item: Element, loop: Bool = false) -> Element? {
        guard let itemIndex = firstIndex(of: item) else { return nil }
        let nextIndex = index(after: itemIndex)

        if nextIndex != endIndex {
            return self[nextIndex]
        } else if loop {
            return first
        } else {
            return nil
        }
    }
}
