import Foundation
import ShipGameKit

@propertyWrapper
public struct CodableDefault<Strategy: DefaultCodableStrategy> {
    public typealias Value = Strategy.Value
    
    public var wrappedValue: Value
    
    public init(wrappedValue: Value = Strategy.defaultValue) {
        self.wrappedValue = wrappedValue
    }
}

// MARK: - Supporting Types

public protocol DefaultCodableStrategy {
    associatedtype Value: Equatable
    
    /// The fallback value used when decoding fails
    static var defaultValue: Value { get }
}

public struct EmptyString: DefaultCodableStrategy {
    public static var defaultValue: String { return "" }
}

public struct True: DefaultCodableStrategy {
    public static var defaultValue: Bool { return true }
}

public struct False: DefaultCodableStrategy {
    public static var defaultValue: Bool { return false }
}

// MARK: - Extensions

extension CodableDefault: Equatable where Value: Equatable {}
extension CodableDefault: Hashable where Value: Hashable {}

extension CodableDefault: Decodable where Value: Decodable {
    // This should never be called since KeyedDecodingContainer should skip it due to the extension.
    public init(from decoder: Decoder) throws {
        throw KippleCodableError.encodingFailure("CodableDefault.init(from:) should never be called!")
    }
}

extension CodableDefault: Encodable where Value: Encodable {
    // This should never be called since KeyedEncodingContainer should skip it due to the extension.
    public func encode(to encoder: Encoder) throws {
        throw KippleCodableError.encodingFailure("CodableDefault.encode(to:) should never be called!")
    }
}

extension KeyedDecodingContainer {
    func decode<Strategy>(
        _ type: CodableDefault<Strategy>.Type,
        forKey key: Key
    ) throws -> CodableDefault<Strategy> where CodableDefault<Strategy>.Value: Decodable {
        try self.decodeIfPresent(type, forKey: key) ?? .init()
    }
}

extension KeyedEncodingContainer {
    // Used to make make sure OmitableFromEncoding never encodes a value
    public mutating func encode<T>(_ value: CodableDefault<T>, forKey key: KeyedEncodingContainer<K>.Key) throws where T.Value: Encodable {
        if value.wrappedValue != T.defaultValue {
            try self.encode(value.wrappedValue, forKey: key)
        }
    }
}
