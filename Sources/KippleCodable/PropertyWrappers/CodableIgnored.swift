// Copyright © 2024 Brian Drelling. All rights reserved.

// TODO: Write tests
// Source: https://stackoverflow.com/a/71087703
@propertyWrapper
public struct CodableIgnored<T>: Codable {
    public var wrappedValue: T?

    public init(wrappedValue: T?) {
        self.wrappedValue = wrappedValue
    }

    public init(from decoder: Decoder) throws {
        self.wrappedValue = nil
    }

    public func encode(to encoder: Encoder) throws {
        // Do nothing
    }
}

extension CodableIgnored: Equatable where T: Equatable {}
extension CodableIgnored: Hashable where T: Hashable {}

public extension KeyedDecodingContainer {
    func decode<T>(
        _ type: CodableIgnored<T>.Type,
        forKey key: Self.Key
    ) throws -> CodableIgnored<T> {
        CodableIgnored(wrappedValue: nil)
    }
}

public extension KeyedEncodingContainer {
    mutating func encode<T>(
        _ value: CodableIgnored<T>,
        forKey key: KeyedEncodingContainer<K>.Key
    ) throws {
        // Do nothing
    }
}
