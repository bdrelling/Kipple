// Copyright © 2021 Brian Drelling. All rights reserved.

// @propertyWrapper
// public struct NonOptional<T: Codable> {
//    private var currentValue: T?
//    private let defaultValue: T
//
//    public init(wrappedValue: T) {
//        self.defaultValue = wrappedValue
//    }
//
//    public var wrappedValue: T {
//        get {
//            self.currentValue ?? self.defaultValue
//        }
//        set {
//            self.currentValue = newValue
//        }
//    }
// }
