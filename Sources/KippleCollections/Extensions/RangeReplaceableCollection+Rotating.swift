// Copyright © 2024 Brian Drelling. All rights reserved.

// Source: https://stackoverflow.com/a/43772545
public extension RangeReplaceableCollection {
    func rotatingLeft(positions: Int) -> SubSequence {
        let index = self.index(startIndex, offsetBy: positions, limitedBy: endIndex) ?? endIndex
        return self[index...] + self[..<index]
    }

    mutating func rotateLeft(positions: Int) {
        let index = self.index(startIndex, offsetBy: positions, limitedBy: endIndex) ?? endIndex
        let slice = self[..<index]
        removeSubrange(..<index)
        insert(contentsOf: slice, at: endIndex)
    }

    func rotatingRight(positions: Int) -> SubSequence {
        let index = self.index(endIndex, offsetBy: -positions, limitedBy: startIndex) ?? startIndex
        return self[index...] + self[..<index]
    }

    mutating func rotateRight(positions: Int) {
        let index = self.index(endIndex, offsetBy: -positions, limitedBy: startIndex) ?? startIndex
        let slice = self[index...]
        removeSubrange(index...)
        insert(contentsOf: slice, at: startIndex)
    }
}
