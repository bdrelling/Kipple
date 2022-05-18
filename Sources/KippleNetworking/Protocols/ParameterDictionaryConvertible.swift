// Copyright © 2022 Brian Drelling. All rights reserved.

public protocol ParameterDictionaryConvertible {
    func asParameterDictionary() -> [String: Any]?
}

public extension ParameterDictionaryConvertible where Self: Encodable {
    func asParameterDictionary() -> [String: Any]? {
        return try? self.asDictionary()
    }
}

extension Dictionary: ParameterDictionaryConvertible where Key == String, Value == Any {
    public func asParameterDictionary() -> [String: Any]? {
        return self
    }
}
