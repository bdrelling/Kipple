// Copyright © 2021 Brian Drelling. All rights reserved.

import Sentry

public enum ErrorHandler {
    public static var globalPrefix: String?
    public static var minimumLogLevel: SentryLevel = .info

    public static func simulateCrash() {
        fatalError("Simulated fatal error.")
    }

    public static func debug(_ message: String, prefix: String? = nil) {
        self.log(message, level: .debug, prefix: prefix)
    }

    public static func info(_ message: String, prefix: String? = nil) {
        self.log(message, level: .info, prefix: prefix)
    }

    public static func warn(_ message: String, prefix: String? = nil) {
        self.log(message, level: .warning, prefix: prefix)
    }

    public static func report(_ error: Error, message: String? = nil, prefix: String? = nil) {
        let formattedMessage: String = {
            if let message = message {
                return "\(message) \(error.localizedDescription)"
            } else {
                return error.localizedDescription
            }
        }()

        self.print(formattedMessage, level: .error, prefix: prefix)

        SentrySDK.capture(error: error) { scope in
            if let message = message {
                scope.setContext(value: [
                    "message": message,
                ], key: "Error Details")
            }
        }
    }

    public static func report(_ message: String, prefix: String? = nil) {
        self.log(message, level: .error, prefix: prefix)
    }

    private static func log(_ message: String, level: SentryLevel, prefix: String?) {
        self.print(message, level: level, prefix: prefix)

        guard level.rawValue >= self.minimumLogLevel.rawValue else {
            return
        }

        SentrySDK.capture(message: message) { scope in
            scope.setLevel(level)
        }
    }

    private static func print(_ message: String, level: SentryLevel, prefix: String?) {
        self.print("[\(level.name)] \(message)", prefix: prefix)
    }

    private static func print(_ message: String, prefix: String?) {
        if let prefix = prefix ?? Self.globalPrefix {
            Swift.print("[\(prefix)] \(message)")
        } else {
            Swift.print(message)
        }
    }
}

extension SentryLevel {
    var name: String {
        switch self {
        case .none:
            return "none"
        case .debug:
            return "debug"
        case .info:
            return "info"
        case .warning:
            return "warning"
        case .error:
            return "error"
        case .fatal:
            return "fatal"
        @unknown default:
            return "unknown"
        }
    }
}
