// Copyright © 2024 Brian Drelling. All rights reserved.

#if os(Linux) && canImport(Logging)

import Foundation
import Logging

public extension Logger {
    // MARK: Constants

    static let defaultLabel = "Kipple"

    // MARK: Initializers

    init(label: String, logLevel: Logger.Level) {
        self.init(label: label)
        self.logLevel = logLevel
    }

    init(label: String, logLevel: Logger.Level, factory: @escaping (String) -> LogHandler) {
        self.init(label: label, factory: factory)
        self.logLevel = logLevel
    }

    init(label: String, logLevel: Logger.Level, logHandler: LogHandler) {
        self.init(label: label, logLevel: logLevel, factory: { _ in logHandler })
    }

    // MARK: Convenience Initializers

    /// The default self.logger is just a best attempt at providing convenient access to logging out-of-the-box.
    /// For all real-world use cases, it is recommended to create your own instance of `KippleLogger` for your application.
    static func `default`(_ label: String = Self.defaultLabel) -> Self {
        .release(label)
    }

    // // For some reason, Swift 5.3 and 5.4 don't know what to do with the #if DEBUG flag within the function block.
    // #if DEBUG
    // /// Creates a `Logger` configured for the active build configuration.
    // /// The default self.logger is just a best attempt at providing convenient access to logging out-of-the-box.
    // /// For all real-world use cases, it is recommended to create your own instance of `KippleLogger` for your application.
    // static func `default`(_ label: String = Self.defaultLabel) -> Self {
    //     return .debug(label)
    // }
    // #else
    // /// Creates a `Logger` configured for the active build configuration.
    // /// The default self.logger is just a best attempt at providing convenient access to logging out-of-the-box.
    // /// For all real-world use cases, it is recommended to create your own instance of `KippleLogger` for your application.
    // static func `default`(_ label: String = Self.defaultLabel) -> Self {
    //     return.release(label)
    // }
    // #endif

    /// Creates a `Logger` configured with the `debug` minimum log level for `debug` configurations.
    static func debug(_ label: String = Self.defaultLabel) -> Self {
        .console(label: label, logLevel: .debug)
    }

    /// Creates a `Logger` configured with the `warning` minimum log level for `release` configurations.
    static func release(_ label: String = Self.defaultLabel) -> Self {
        .console(label: label, logLevel: .warning)
    }

    /// Creates a `Logger` configured to log to the console.
    static func console(label: String, logLevel: Logger.Level) -> Self {
        .init(label: label, logLevel: logLevel, logHandler: ConsoleLogHandler(label: label))
    }
}

// MARK: Logging Convenience Methods

public extension Logger {
    // MARK: Methods - Message Logging

    /// Logs a message with an associated log level.
    /// - Parameters:
    ///    - message: The message to be logged. `message` can be used with any string interpolation literal.
    ///    - level: The log level to log `message` at. For the available log levels, see `Logger.Level`.
    ///    - metadata: One-off metadata to attach to this log message.
    ///    - file: The file this log message originates from (defaults to `#file`).
    ///    - function: The function this log message originates from (defaults to `#function`).
    ///    - line: The line this log message originates from (defaults to `#line`).
    func log(
        _ message: String,
        level: Logger.Level,
        metadata: Logger.Metadata? = nil,
        file: String = #file,
        function: String = #function,
        line: UInt = #line
    ) {
        self.log(level: level, "\(message)", metadata: metadata, file: file, function: function, line: line)
    }

    // MARK: Methods - Error Reporting

    /// Reports an error with an associated log level.
    /// - Parameters:
    ///    - error: The error to be logged. `error` is combined with `message` for easy error reporting.
    ///    - message: The message to be logged. `message` can be used with any string interpolation literal.
    ///    - level: The log level to log `message` at. For the available log levels, see `Logger.Level`.
    ///    - metadata: One-off metadata to attach to this log message.
    ///    - file: The file this log message originates from (defaults to `#file`).
    ///    - function: The function this log message originates from (defaults to `#function`).
    ///    - line: The line this log message originates from (defaults to `#line`).
    func report(
        _ error: Error,
        message: String? = nil,
        level: Logger.Level = .error,
        metadata: Logger.Metadata? = nil,
        file: String = #file,
        function: String = #function,
        line: UInt = #line
    ) {
        let formattedMessage: String = {
            if let message = message {
                return "\(message) \(error.localizedDescription)"
            } else {
                return error.localizedDescription
            }
        }()

        self.log(formattedMessage, level: level, metadata: metadata, file: file, function: function, line: line)
    }

    /// Logs a message with the `debug` log level.
    /// - Parameters:
    ///    - message: The message to be logged. `message` can be used with any string interpolation literal.
    ///    - metadata: One-off metadata to attach to this log message.
    ///    - file: The file this log message originates from (defaults to `#file`).
    ///    - function: The function this log message originates from (defaults to `#function`).
    ///    - line: The line this log message originates from (defaults to `#line`).
    func debug(
        _ message: String,
        metadata: Logger.Metadata? = nil,
        file: String = #file,
        function: String = #function,
        line: UInt = #line
    ) {
        self.log(message, level: .debug, metadata: metadata, file: file, function: function, line: line)
    }

    /// Logs a message with the `info` log level.
    /// - Parameters:
    ///    - message: The message to be logged. `message` can be used with any string interpolation literal.
    ///    - metadata: One-off metadata to attach to this log message.
    ///    - file: The file this log message originates from (defaults to `#file`).
    ///    - function: The function this log message originates from (defaults to `#function`).
    ///    - line: The line this log message originates from (defaults to `#line`).
    func info(
        _ message: String,
        metadata: Logger.Metadata? = nil,
        file: String = #file,
        function: String = #function,
        line: UInt = #line
    ) {
        self.log(message, level: .info, metadata: metadata, file: file, function: function, line: line)
    }

    /// Logs a message with the `warning` log level.
    /// - Parameters:
    ///    - message: The message to be logged. `message` can be used with any string interpolation literal.
    ///    - metadata: One-off metadata to attach to this log message.
    ///    - file: The file this log message originates from (defaults to `#file`).
    ///    - function: The function this log message originates from (defaults to `#function`).
    ///    - line: The line this log message originates from (defaults to `#line`).
    func warning(
        _ message: String,
        metadata: Logger.Metadata? = nil,
        file: String = #file,
        function: String = #function,
        line: UInt = #line
    ) {
        self.log(message, level: .warning, metadata: metadata, file: file, function: function, line: line)
    }

    /// Logs a message with the `report` log level.
    /// - Parameters:
    ///    - message: The message to be logged. `message` can be used with any string interpolation literal.
    ///    - metadata: One-off metadata to attach to this log message.
    ///    - file: The file this log message originates from (defaults to `#file`).
    ///    - function: The function this log message originates from (defaults to `#function`).
    ///    - line: The line this log message originates from (defaults to `#line`).
    func report(
        _ message: String,
        metadata: Logger.Metadata? = nil,
        file: String = #file,
        function: String = #function,
        line: UInt = #line
    ) {
        self.report(GenericError(message), metadata: metadata, file: file, function: function, line: line)
    }
}

private struct GenericError: LocalizedError {
    let message: String

    init(_ message: String) {
        self.message = message
    }

    var errorDescription: String? {
        self.message
    }
}

#endif
