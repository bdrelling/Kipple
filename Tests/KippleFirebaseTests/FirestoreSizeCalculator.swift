// Copyright © 2021 Brian Drelling. All rights reserved.

import FirebaseFirestore
import FirebaseFirestoreSwift

public enum FirestoreSizeCalculator {
    static func calculateDocumentSize(of object: Any) -> Int {
        let properties = properties(of: object)
        return properties
            .compactMap { property in
                let nameSize = calculateFirestoreSize(of: property.name)
                let valueSize = calculateFirestoreSize(of: property.value)
                return nameSize + valueSize
            }
            .reduce(0, +)
    }

    static func calculateSize(of value: Any) -> Int {
        switch value {
        case is DocumentID<String>:
            // FIXME: This isn't true! https://firebase.google.com/docs/firestore/storage-size#document-name-size
            // DocumentIDs are not factored into the size of the document.
            return 0
        case is ServerTimestamp<Date>,
             is Date:
            // Always 8 bytes
            return 8
        case is Bool:
            // Always 1 byte
            return 1
        case is Int,
             is Float,
             is Double:
            // Always 8 bytes
            return 8
        case let value as String:
            // Number of UTF-8 encoded bytes + 1
            return value.lengthOfBytes(using: .utf8) + 1
        //    case is Array<Any>:
        //        break
        case nil:
            // Nil values are not sent to Firestore by default.
            // If they are sent, the field size only 1 byte, plus the Firestore size of the field name.
            return 0
        default:
            return calculateReflectedFirestoreSize(of: value)
        }
    }

    static func calculateReflectedSize(of value: Any) -> Int {
        let mirror = Mirror(reflecting: value)

        switch mirror.displayStyle {
        case .none:
            return 0
        case .class,
             .struct,
             .tuple:
            return mirror.children
                .compactMap { child in
                    let nameSize = calculateFirestoreSize(of: child.label as Any)
                    let valueSize = calculateFirestoreSize(of: child.value)
                    return nameSize + valueSize
                }
                .reduce(0, +)
        case .optional:
            if let unwrappedValue = mirror.children.first?.value {
                return calculateFirestoreSize(of: unwrappedValue)
            } else {
                return 0
            }
        case .collection,
             .set:
            return mirror.children
                .map { calculateFirestoreSize(of: $0.value) }
                .reduce(0, +)
        case .dictionary,
             .enum:
            return 0
        @unknown default:
            return 0
        }
    }

    static func properties(of object: Any) -> [Property] {
        Mirror(reflecting: object)
            .children
            .compactMap { child in
                guard let label = child.label else {
                    return nil
                }

                // Remove non-alphanumeric characters such as underscores, which are not submitted to Firestore.
                let name = label.trimmingCharacters(in: .alphanumerics.inverted)

                return Property(name: name, value: child.value)
            }
            .sorted { $0.name < $1.name }
    }
}

struct Property {
    let name: String
    let value: Any
}

extension Property: CustomStringConvertible {
    var description: String {
        let displayStyle = Mirror(reflecting: self.value).displayStyle

        let typeName: String = {
            if let style = displayStyle {
                return "[\(String(describing: style))] "
            } else {
                return ""
            }
        }()

        return "\(typeName)\(self.name) = \(String(describing: self.value))"
    }
}
