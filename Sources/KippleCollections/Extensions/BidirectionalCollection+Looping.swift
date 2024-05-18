// Copyright © 2024 Brian Drelling. All rights reserved.

public extension BidirectionalCollection {
    func previousIndex(looping: Bool = false, before predicate: (Element) throws -> Bool) rethrows -> Index? {
        guard let currentIndex = try self.firstIndex(where: predicate) else {
            return nil
        }

        // Get the index for the next element in the array
        let index = self.index(before: currentIndex)

        // If the index exceeds the element count, we need to loop back to the first element
        if index < self.startIndex {
            return looping ? self.index(before: endIndex) : nil
        } else {
            return index
        }
    }

    func previous(looping: Bool = false, before predicate: (Element) throws -> Bool) rethrows -> Element? {
        // Get the index for the next element in the array
        guard let index = try self.previousIndex(looping: looping, before: predicate) else {
            return nil
        }

        return self[index]
    }

    func nextIndex(looping: Bool = false, after predicate: (Element) throws -> Bool) rethrows -> Index? {
        guard let currentIndex = try self.firstIndex(where: predicate) else {
            return nil
        }

        // Get the index for the next element in the array
        let index = self.index(after: currentIndex)

        // If the index exceeds the element count, we need to loop back to the first element
        if index >= self.endIndex {
            return looping ? self.startIndex : nil
        } else {
            return index
        }
    }

    func next(looping: Bool = false, after predicate: (Element) throws -> Bool) rethrows -> Element? {
        // Get the index for the next element in the array
        guard let index = try self.nextIndex(looping: looping, after: predicate) else {
            return nil
        }

        return self[index]
    }
}

public extension Array where Element: Equatable {
    func previousIndex(looping: Bool = false, before element: Element) -> Index? {
        self.previousIndex(looping: looping) { $0 == element }
    }

    func previous(looping: Bool = false, before element: Element) -> Element? {
        self.previous(looping: looping) { $0 == element }
    }

    func nextIndex(looping: Bool = false, after element: Element) -> Index? {
        self.nextIndex(looping: looping) { $0 == element }
    }

    func next(looping: Bool = false, after element: Element) -> Element? {
        self.next(looping: looping) { $0 == element }
    }
}

public extension Array where Element: Identifiable {
    func previousIndex(looping: Bool = false, before id: Element.ID) -> Index? {
        self.previousIndex(looping: looping) { $0.id == id }
    }

    func previous(looping: Bool = false, before id: Element.ID) -> Element? {
        self.previous(looping: looping) { $0.id == id }
    }

    func nextIndex(looping: Bool = false, after id: Element.ID) -> Index? {
        self.nextIndex(looping: looping) { $0.id == id }
    }

    func next(looping: Bool = false, after id: Element.ID) -> Element? {
        self.next(looping: looping) { $0.id == id }
    }
}
