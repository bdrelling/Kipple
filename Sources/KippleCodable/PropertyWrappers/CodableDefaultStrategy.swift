// Copyright © 2024 Brian Drelling. All rights reserved.

public protocol CodableDefaultStrategy {
    associatedtype Value: Equatable

    /// The fallback value used when decoding fails
    static var defaultValue: Value { get }
}

// MARK: - Supporting Types

public struct EmptyString: CodableDefaultStrategy {
    public static var defaultValue: String { "" }
}

public struct TrueBool: CodableDefaultStrategy {
    public static var defaultValue: Bool { true }
}

public struct FalseBool: CodableDefaultStrategy {
    public static var defaultValue: Bool { false }
}

public struct ZeroInteger<Number: FixedWidthInteger>: CodableDefaultStrategy {
    public static var defaultValue: Number { 0 }
}

public struct ZeroFloatingPoint<Number: BinaryFloatingPoint>: CodableDefaultStrategy {
    public static var defaultValue: Number { 0 }
}

public struct Null<Value>: CodableDefaultStrategy where Value: Equatable {
    public static var defaultValue: Value? { nil }
}

// MARK: - Convenience

public typealias CodableDefaultEmptyString = CodableDefault<EmptyString>
public typealias CodableDefaultTrue = CodableDefault<TrueBool>
public typealias CodableDefaultFalse = CodableDefault<FalseBool>
public typealias CodableDefaultZeroInt = CodableDefault<ZeroInteger<Int>>
public typealias CodableDefaultZeroFloat = CodableDefault<ZeroFloatingPoint<Float>>
public typealias CodableDefaultZeroDouble = CodableDefault<ZeroFloatingPoint<Double>>
public typealias CodableDefaultNull<Value> = CodableDefault<Null<Value>> where Value: Equatable
