// Copyright © 2021 Brian Drelling. All rights reserved.

import Combine

public extension Publisher where Failure == Error {
    func sinkResult(receiveValue: @escaping (Result<Output, Failure>) -> Void) -> AnyCancellable {
        self.map(Result.success)
            .catch { Just(.failure($0)) }
            .sink(receiveValue: receiveValue)
    }
}