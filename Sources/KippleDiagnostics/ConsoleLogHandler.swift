// Copyright © 2022 Brian Drelling. All rights reserved.

import Logging
import Sentry

public struct ConsoleLogHandler {
    // MARK: Properties

    /// The global log level threshold that determines when to send log output to the console.
    /// Defaults to `.debug`.
    ///
    /// The `logLevel` of an individual `ConsoleLogHandler` is ignored when this global
    /// log level is set to a higher level.
    public static var globalLogLevel: Logger.Level = .debug

    /// The log label for the log handler.
    public var label: String

    /// Whether or not the log messages should include the timestamp.
    public var shouldIncludeTimestamp: Bool = true

    /// Prettified metadata string for simplified logging.
    private var prettyMetadata: String?

    // MARK: LogHandler Properties

    public var logLevel: Logger.Level = .info

    public var metadata = Logger.Metadata() {
        didSet {
            self.prettyMetadata = self.prettify(self.metadata)
        }
    }

    // MARK: Initializers

    init(label: String) {
        self.label = label
    }
}

// MARK: - Extensions

extension ConsoleLogHandler: LogHandler {
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

        var formattedMessage = message.description
            .prependingLogPrefix(level.rawValue)
            .prependingLogPrefix(self.label, isInBrackets: false)

        if self.shouldIncludeTimestamp {
            formattedMessage = formattedMessage.prependingTimestamp()
        }

        let prettyMetadata = metadata?.isEmpty ?? true
            ? self.prettyMetadata
            : self.prettify(self.metadata.merging(metadata!, uniquingKeysWith: { _, new in new }))

        if let prettyMetadata = prettyMetadata {
            formattedMessage = formattedMessage.appending(prettyMetadata)
        }

        print(formattedMessage)
    }

    // Source: https://github.com/apple/swift-log/blob/02770d91fc9635df6400494f4b2c97e513e39719/Sources/Logging/Logging.swift#L1127-L1131
    private func prettify(_ metadata: Logger.Metadata) -> String? {
        !metadata.isEmpty
            ? metadata.lazy.sorted(by: { $0.key < $1.key }).map { "\($0)=\($1)" }.joined(separator: " ")
            : nil
    }
}

private extension String {
    func prependingLogPrefix(_ prefix: String, isInBrackets: Bool = true) -> String {
        if isInBrackets {
            return "[\(prefix)] \(self)"
        } else {
            return "\(prefix) \(self)"
        }
    }

    func appending(_ message: String) -> String {
        "\(self) \(message)"
    }
}

private extension String {
    func prependingTimestamp() -> String {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSSZ"

        return self.prependingLogPrefix(formatter.string(from: now), isInBrackets: false)
    }
}
