// Copyright © 2024 Brian Drelling. All rights reserved.

#if os(Linux) && canImport(Logging)

import Foundation
import Logging

public struct ConsoleLogHandler {
    // MARK: Properties

    /// The global log level threshold that determines when to send log output to the console.
    /// Defaults to `nil`, implying that the `Logger`'s `logLevel` is respected entirely.
    ///
    /// The `logLevel` of an individual `ConsoleLogHandler` is ignored when this global
    /// log level is set to a higher level.
    public static var globalLogLevel: Logger.Level?

    /// The log label for the log handler.
    public var label: String

    /// Whether or not the log messages should include the timestamp.
    public var shouldIncludeTimestamp: Bool = true

    /// Prettified metadata string for simplified logging.
    private var prettyMetadata: String?

    /// The formatter to use when printing date timestamps.
    public var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSSZ"

        return formatter
    }()

    // MARK: LogHandler Properties

    public var logLevel: Logger.Level = .info

    public var metadata = Logger.Metadata() {
        didSet {
            self.prettyMetadata = self.prettify(self.metadata)
        }
    }

    // MARK: Initializers

    public init(label: String) {
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

    /// This method is called when a `LogHandler` must emit a log message. There is no need for the `LogHandler` to
    /// check if the `level` is above or below the configured `logLevel` as `Logger` already performed this check and
    /// determined that a message should be logged.
    ///
    /// - parameters:
    ///     - level: The log level the message was logged at.
    ///     - message: The message to log. To obtain a `String` representation call `message.description`.
    ///     - metadata: The metadata associated to this log message.
    ///     - source: The source where the log message originated, for example the logging module.
    ///     - file: The file the log message was emitted from.
    ///     - function: The function the log line was emitted from.
    ///     - line: The line the log message was emitted from.
    public func log(
        level: Logger.Level,
        message: Logger.Message,
        metadata: Logger.Metadata?,
        source: String,
        file: String,
        function: String,
        line: UInt
    ) {
        // If there is no global log level currently set, use the lowest log level available.
        // This ensures that it will respect the parent Logger's log level instead.
        let globalLogLevel = Self.globalLogLevel ?? .trace

        guard level >= globalLogLevel else {
            return
        }

        var items: [String?] = []

        // Timestamp (optional)
        if self.shouldIncludeTimestamp {
            items.append(self.dateFormatter.string(from: Date()))
        }

        // Label
        items.append(self.label)

        // Log Level
        // We wrap this in brackets to help identify the start of the log message.
        items.append("[\(level.rawValue)]")

        // Message
        items.append(message.description)

        // Code Information
        if let filename = file.split(separator: "/").last {
            items.append("[\(filename):\(line) \(function)]")
        }

        // Metadata
        // This snippet is copied verbatim from swift-log.
        // Source: https://github.com/apple/swift-log/blob/f2e8667d508016531ba5d044b739eae1ae532a30/Sources/Logging/Logging.swift#L1132-1134
        let prettyMetadata = metadata?.isEmpty ?? true
            ? self.prettyMetadata
            : self.prettify(self.metadata.merging(metadata!, uniquingKeysWith: { _, new in new }))
        items.append(prettyMetadata)

        // Build our formatted message
        let formattedMessage = items.compactMap { $0 }.joined(separator: " ")

        print(formattedMessage)
    }

    // This method is copied verbatim from swift-log.
    // Source: https://github.com/apple/swift-log/blob/f2e8667d508016531ba5d044b739eae1ae532a30/Sources/Logging/Logging.swift#L1140-1144
    private func prettify(_ metadata: Logger.Metadata) -> String? {
        !metadata.isEmpty
            ? metadata.lazy.sorted(by: { $0.key < $1.key }).map { "\($0)=\($1)" }.joined(separator: " ")
            : nil
    }
}

// MARK: - Convenience

extension LogHandler where Self == ConsoleLogHandler {
    static func console(label: String) -> Self {
        .init(label: label)
    }
}

#endif
