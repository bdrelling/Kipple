// Copyright © 2024 Brian Drelling. All rights reserved.

/// A protocol defining a strategy for providing a default value when Codable decoding fails.
public protocol CodableDefaultStrategy {
    associatedtype Value: Equatable

    /// The fallback value used when decoding fails.
    static var defaultValue: Value { get }
}

// MARK: - Supporting Types

/// A CodableDefaultStrategy providing an empty string as the default value.
public struct EmptyString: CodableDefaultStrategy {
    public static var defaultValue: String { "" }
}

/// A CodableDefaultStrategy providing `true` as the default value.
public struct TrueBool: CodableDefaultStrategy {
    public static var defaultValue: Bool { true }
}

/// A CodableDefaultStrategy providing `false` as the default value.
public struct FalseBool: CodableDefaultStrategy {
    public static var defaultValue: Bool { false }
}

/// A CodableDefaultStrategy providing zero as the default value for any FixedWidthInteger type.
public struct ZeroInteger<Number: FixedWidthInteger>: CodableDefaultStrategy {
    public static var defaultValue: Number { 0 }
}

/// A CodableDefaultStrategy providing zero as the default value for any BinaryFloatingPoint type.
public struct ZeroFloatingPoint<Number: BinaryFloatingPoint>: CodableDefaultStrategy {
    public static var defaultValue: Number { 0 }
}

/// A CodableDefaultStrategy providing `nil` as the default value for any Equatable type.
public struct Null<Value>: CodableDefaultStrategy where Value: Equatable {
    public static var defaultValue: Value? { nil }
}

// MARK: - Convenience

/// A typealias for CodableDefault with an `EmptyString` strategy.
public typealias CodableDefaultEmptyString = CodableDefault<EmptyString>
/// A typealias for CodableDefault with a `TrueBool` strategy.
public typealias CodableDefaultTrue = CodableDefault<TrueBool>
/// A typealias for CodableDefault with a `FalseBool` strategy.
public typealias CodableDefaultFalse = CodableDefault<FalseBool>
/// A typealias for CodableDefault with a `ZeroInteger` strategy for `Int`.
public typealias CodableDefaultZeroInt = CodableDefault<ZeroInteger<Int>>
/// A typealias for CodableDefault with a `ZeroFloatingPoint` strategy for `Float`.
public typealias CodableDefaultZeroFloat = CodableDefault<ZeroFloatingPoint<Float>>
/// A typealias for CodableDefault with a `ZeroFloatingPoint` strategy for `Double`.
public typealias CodableDefaultZeroDouble = CodableDefault<ZeroFloatingPoint<Double>>
/// A typealias for CodableDefault with a `Null` strategy, simplifying usage for optional values.
public typealias CodableDefaultNull<Value> = CodableDefault<Null<Value>> where Value: Equatable
