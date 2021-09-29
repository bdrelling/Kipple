// Copyright © 2021 Brian Drelling. All rights reserved.

import Combine

public extension Publisher {
    func printErrors(_ prefix: String? = nil) -> AnyPublisher<Output, Failure> {
        self
            .catch { error -> AnyPublisher<Output, Failure> in
                let message: String = {
                    if let prefix = prefix {
                        return "\(prefix): \(error.localizedDescription)"
                    } else {
                        return error.localizedDescription
                    }
                }()

                // Specify the Swift prefix, otherwise it assumes Publisher.print
                Swift.print(message)

                return self.eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
