// Copyright © 2021 Brian Drelling. All rights reserved.

import Sentry

public enum SentryHelper {
    public static func initialize(dsn: String, environment: String) {
        SentrySDK.start { options in
            options.dsn = dsn

            // Set the environment for better bucketing of events and transactions.
            options.environment = environment

            // Enable debugging and set diagnostic level.
            options.debug = false
            options.diagnosticLevel = .debug

            options.enableAutoPerformanceTracking = true

            // Set the sample rate for Error Handling Events. 1.0 == 100%.
            options.sampleRate = 1.0

            // Set the sample rate for Performance Traces. 1.0 == 100%.
            options.tracesSampleRate = 1.0

            // determine traces sample rate based on the sampling context
//            options.tracesSampler = { context in
//                 // Don't miss any transactions for VIP users
//                if context?["vip"] as? Bool == true {
//                    return 1.0
//                } else {
//                    return 0.25 // 25% for everything else
//                }
//            }
        }
    }

    public static func setUser(id: String?, username: String?) {
        guard let id = id else {
            self.clearUser()
            return
        }

        let user = Sentry.User(userId: id)
        user.username = username

        SentrySDK.setUser(user)
    }

    public static func clearUser() {
        SentrySDK.setUser(nil)
    }

    public static func simulateCrash() {
        SentrySDK.crash()
    }

    public static func simulatePerformanceTransaction() {
        // Transaction can be started by providing the name and the operation
        let transaction = SentrySDK.startTransaction(
            name: "simulated-transaction",
            operation: "simulated-transaction-operation"
        )

        // Transactions can have child spans, and those spans can have child spans as well.
        let span = transaction.startChild(operation: "child-operation")

        span.finish() // Remember that only finished spans will be sent with the transaction
        transaction.finish() // Finishing the transaction will send it to Sentry
    }
}
