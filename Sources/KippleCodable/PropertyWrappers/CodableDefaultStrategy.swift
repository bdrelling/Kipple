public protocol DefaultCodableStrategy {
    associatedtype Value: Equatable
    
    /// The fallback value used when decoding fails
    static var defaultValue: Value { get }
}

public struct EmptyString: DefaultCodableStrategy {
    public static var defaultValue: String { return "" }
}

public struct TrueBool: DefaultCodableStrategy {
    public static var defaultValue: Bool { return true }
}

public struct FalseBool: DefaultCodableStrategy {
    public static var defaultValue: Bool { return false }
}

public typealias DefaultEmptyString = CodableDefault<EmptyString>
public typealias DefaultTrue = CodableDefault<TrueBool>
public typealias DefaultFalse = CodableDefault<FalseBool>
