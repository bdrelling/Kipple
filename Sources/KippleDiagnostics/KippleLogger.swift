// Copyright © 2021 Brian Drelling. All rights reserved.

import Logging
import Pulse

public enum KippleLogger {
    // MARK: Properties

    private static var logger = Logger(label: "KippleDiagnostics", factory: Self.logHandler)

    public static var logLevel: Logger.Level {
        get {
            self.logger.logLevel
        }
        set {
            self.logger.logLevel = newValue
        }
    }

    // MARK: Methods

    public static func initializeLogging(label: String, logLevel: Logger.Level = .info) {
        // Initialize all loggers to go through the default log handler.
        LoggingSystem.bootstrap(Self.logHandler)

        // Initialize the logger if a new label was provided.
        if self.logger.label != label {
            self.logger = Logger(label: label, factory: Self.logHandler)
        }

        // Set the log level for the logger.
        self.logger.logLevel = logLevel
    }

//    public static func initializeNetworkLogging() {
//        URLSessionProxyDelegate.enableAutomaticRegistration()
//    }

    private static func logHandler(label: String) -> LogHandler {
        var handlers: [LogHandler] = []

        // Add Pulse logging
        handlers.append(PersistentLogHandler(label: label))

        // Add Sentry logging
        handlers.append(SentryLogHandler(label: label))

        // TODO: Disable console logging when not attached to debugger.
        // Add console logging, but only when debugging
        handlers.append(ConsoleLogHandler(label: label))
//        handlers.append(StreamLogHandler.standardOutput(label: label))

        return MultiplexLogHandler(handlers)
    }

    // MARK: Message Logging

    public static func log(
        _ message: String,
        level: Logger.Level,
        metadata: Logger.Metadata? = nil,
        file: String = #file,
        function: String = #function,
        line: UInt = #line
    ) {
        self.logger.log(level: level, "\(message)", metadata: metadata, file: file, function: function, line: line)
    }

    public static func debug(
        _ message: String,
        metadata: Logger.Metadata? = nil,
        file: String = #file,
        function: String = #function,
        line: UInt = #line
    ) {
        self.log(message, level: .debug, metadata: metadata, file: file, function: function, line: line)
    }

    public static func info(
        _ message: String,
        metadata: Logger.Metadata? = nil,
        file: String = #file,
        function: String = #function,
        line: UInt = #line
    ) {
        self.log(message, level: .info, metadata: metadata, file: file, function: function, line: line)
    }

    public static func warning(
        _ message: String,
        metadata: Logger.Metadata? = nil,
        file: String = #file,
        function: String = #function,
        line: UInt = #line
    ) {
        self.log(message, level: .warning, metadata: metadata, file: file, function: function, line: line)
    }

    // MARK: Error Reporting

    public static func report(
        _ error: Error,
        message: String? = nil,
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

        self.log(formattedMessage, level: .error, metadata: metadata, file: file, function: function, line: line)

        // TODO: Figure out how to abstract this from KippleLogger?
        SentryLogHandler.report(error: error, message: message, file: file, function: function, line: line)
    }

    public static func report(
        _ message: String,
        metadata: Logger.Metadata? = nil,
        file: String = #file,
        function: String = #function,
        line: UInt = #line
    ) {
        self.report(GenericError(message), metadata: metadata, file: file, function: function, line: line)
    }
}
