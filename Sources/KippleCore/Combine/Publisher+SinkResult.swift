// Copyright © 2021 Brian Drelling. All rights reserved.

import Combine

// TODO: Migrate to Kipple
public extension Publisher {
    func sinkResult(receiveValue: @escaping (Result<Output, Failure>) -> Void) -> AnyCancellable {
        self.map(Result.success)
            .catch { Just(.failure($0)) }
            .sink(receiveValue: receiveValue)
    }
}
