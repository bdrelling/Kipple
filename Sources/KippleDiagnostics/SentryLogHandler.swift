// Copyright © 2022 Brian Drelling. All rights reserved.

import Logging
import Sentry

public struct SentryLogHandler {
    // MARK: Properties

    /// The global log level threshold that determines when to send log output to Sentry.
    /// Defaults to `.warning`.
    ///
    /// The `logLevel` of an individual `SentryLogHandler` is ignored when this global
    /// log level is set to a higher level.
    public static var globalLogLevel: Logger.Level = .warning

    /// The log label for the log handler.
    public var label: String

    // MARK: LogHandler Properties

    public var metadata = Logger.Metadata()
    public var logLevel: Logger.Level = .info

    // MARK: Initializers

    init(label: String) {
        self.label = label
    }

    // TODO: Figure out how to abstract this from SentryLogHandler?
    public static func report(
        error: Error,
        message: String?,
        file: String,
        function: String,
        line: UInt
    ) {
        SentrySDK.capture(error: error) { scope in
            if let message = message {
                scope.setContext(
                    value: [
                        "localizedDescription": error.localizedDescription,
                        "message": message,
                    ],
                    key: "Error Details"
                )
            }
        }
    }
}

// MARK: - Extensions

extension SentryLogHandler: LogHandler {
    public subscript(metadataKey metadataKey: String) -> Logger.Metadata.Value? {
        get {
            self.metadata[metadataKey]
        }
        set {
            self.metadata[metadataKey] = newValue
        }
    }

    public func log(
        level: Logger.Level,
        message: Logger.Message,
        metadata: Logger.Metadata?,
        source: String,
        file: String,
        function: String,
        line: UInt
    ) {
        guard level >= Self.globalLogLevel else {
            return
        }

        SentrySDK.capture(message: message.description) { scope in
            scope.setLevel(level.sentryLevel)
        }
    }
}

private extension Logger.Level {
    var sentryLevel: SentryLevel {
        switch self {
        case .trace:
            return .debug
        case .debug:
            return .debug
        case .info:
            return .info
        case .notice:
            return .warning
        case .warning:
            return .warning
        case .error:
            return .error
        case .critical:
            return .fatal
        }
    }
}
