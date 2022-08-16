// Copyright © 2022 Brian Drelling. All rights reserved.

import Combine
import Foundation
import SwiftUI

// TODO: Explore rewriting this with a CurrentValueSubject in mind, and debounce the saving (and maybe fetching?)
@propertyWrapper
public struct LocalStorage<Value> where Value: Codable, Value: Equatable {
    private let key: String
    private let defaultValue: Value
    private let store: LocalStore

    public var wrappedValue: Value {
        didSet {
            self.store(key: self.key, newValue: self.wrappedValue)
            self.projectedValue.send(self.wrappedValue)
        }
    }

    public var projectedValue: CurrentValueSubject<Value, Never>

    public init(wrappedValue: Value, _ key: String, store: LocalStore = .init()) {
        self.key = key
        self.defaultValue = wrappedValue
        self.store = store

        self.wrappedValue = self.store.value(forKey: key, defaultValue: wrappedValue)
        self.projectedValue = .init(wrappedValue)
    }

    public init<Key>(wrappedValue: Value, _ key: Key, store: LocalStore = .init()) where Key: RawRepresentable, Key.RawValue == String {
        self.init(wrappedValue: wrappedValue, key.rawValue, store: store)
    }

    public func clear() {
        self.store.remove(key: self.key)
    }

    private func fetch(key: String, defaultValue: Value) -> Value {
        self.store.value(forKey: key, defaultValue: defaultValue)
    }

    private func store(key: String, newValue: Value) {
        try? self.store.set(key: key, newValue: newValue)
    }
}

// MARK: - Extensions

extension LocalStorage: Equatable {
    public static func == (lhs: LocalStorage<Value>, rhs: LocalStorage<Value>) -> Bool {
        // We don't care about the equality of the property wrapper itself,
        // we only care about the equality of the underlying data.
        lhs.wrappedValue == rhs.wrappedValue
    }
}

extension LocalStorage: CustomStringConvertible {
    public var description: String {
        String(describing: self.wrappedValue)
    }
}
