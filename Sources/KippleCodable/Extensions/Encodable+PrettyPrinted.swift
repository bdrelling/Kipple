// Copyright © 2024 Brian Drelling. All rights reserved.

import Foundation

public extension Encodable {
    /// Produces a pretty-printed string representation of the encoded data.
    func prettyPrinted(mode: PrettyPrintMode = .json) throws -> String {
        switch mode {
        case .json:
            let encoder: JSONEncoder = .prettyPrinter
            let prettyPrintedData = try encoder.encode(self)

            guard let prettyPrintedString = String(data: prettyPrintedData, encoding: .utf8) else {
                throw PrettyPrintError.unableToConvertData(prettyPrintedData)
            }

            return prettyPrintedString
        }
    }
}

public extension CustomDebugStringConvertible where Self: Encodable {
    var debugDescription: String {
        (try? self.prettyPrinted()) ?? String(describing: self)
    }
}

// MARK: - Supporting Types

public enum PrettyPrintMode {
    case json
}

/// A supporting type to avoid recreating JSONEncoder for every call to `PrettyPrintable.prettyPrinted(mode:)`.
private extension JSONEncoder {
    static let prettyPrinter: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        return encoder
    }()
}

public enum PrettyPrintError: LocalizedError {
    case unableToConvertData(Data)

    public var errorDescription: String? {
        switch self {
        case .unableToConvertData:
            return "Unable to convert data into pretty printed string."
        }
    }
}
