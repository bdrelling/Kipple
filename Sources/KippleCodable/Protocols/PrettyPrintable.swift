import Foundation

public protocol PrettyPrintable {}

public extension PrettyPrintable where Self: Encodable {
    // TODO: Remove expensive re-creation of JSONEncoder.
    // TODO: Order the keys in the dictionaries.
    func prettyPrinted(mode: PrettyPrintMode = .json) -> String {
        do {
            switch mode {
            case .json:
                let data = try JSONEncoder().encode(self)
                let jsonObject = try JSONSerialization.jsonObject(with: data)
                let prettyPrintedData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
                return String(data: prettyPrintedData, encoding: .utf8) ?? "ERROR: Unable to convert data into pretty printed string."
            }
        } catch {
            return "ERROR: \(error.localizedDescription)"
        }
    }
}

// MARK: - Supporting Types

public enum PrettyPrintMode {
    case json
}

// MARK: - Extensions

public extension CustomDebugStringConvertible where Self: PrettyPrintable, Self: Encodable {
    var debugDescription: String {
        self.prettyPrinted()
    }
}
