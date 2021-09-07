// Copyright © 2021 Brian Drelling. All rights reserved.

import FirebaseFirestore
import Foundation

public typealias FirestoreEncodableDictionary = [AnyHashable: Any]
public typealias FirestoreEncodedDictionary = [AnyHashable: Any]

public extension Encodable {
    func firestoreEncoded() throws -> FirestoreEncodedDictionary {
        try Firestore.Encoder().encode(self)
    }
}

public extension Dictionary where Key == String, Value: Encodable {
    func firestoreEncoded() throws -> FirestoreEncodedDictionary {
        try Firestore.Encoder().encode(self)
    }
}

// public extension FirestoreEncodableDictionary {
//    #warning("This shit doesn't work.")
//    func firestoreEncoded() throws -> FirestoreEncodedDictionary {
//        try Firestore.Encoder().encode(self)
//        var encodedDictionary: [String: Any] = [:]
//
//        for (key, value) in self {
//            encodedDictionary[key] = try value.firestoreEncoded()
//        }
//
//        return encodedDictionary
//    }
// }

// public extension Array where Element: Encodable {
//    /// Encodes an Array as a Firestore-compatible dictionary, with indexes for keys.
//    func firestoreEncoded() throws -> [FirestoreEncodedDictionary] {
//        try self.map { try $0.firestoreEncoded() }
////        try self.enumerated()
////            .map { (key: String($0), value: try $1.firestoreEncoded()) }
////            .reduce(into: [:]) { dictionary, value in
////                dictionary[value.key] = value.value
////        }
//    }
// }

public extension Array where Element: RawRepresentable, Element.RawValue == String {
    func firestoreEncoded() throws -> [String] {
        self.map(\.rawValue)
    }
}
