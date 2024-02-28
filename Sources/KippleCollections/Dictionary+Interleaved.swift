// TODO: Write tests
// TODO: Make more efficient?
public extension Dictionary where Key: Comparable, Value: Collection {
    func interleaved() -> [(Key, Value.Element)] {
        self.map { ($0.key, $0.value) }
            .flatMap { key, values in
                values.enumerated()
                    .map { (key: key, index: $0.offset, value: $0.element) }
            }
            .sorted { lhs, rhs in
                if lhs.index == rhs.index {
                    return lhs.key < rhs.key
                } else {
                    return lhs.index < rhs.index
                }
            }
            .map { ($0.key, $0.value) }
    }
}
