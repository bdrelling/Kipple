// Copyright © 2024 Brian Drelling. All rights reserved.

#if canImport(Combine)

import Combine

public extension Publisher where Failure == Error {
    func convertToResult() -> some Publisher<Result<Output, Failure>, Never> {
        self.map(Result.success)
            .catch { Just(.failure($0)) }
    }

    func sinkResult(receiveValue: @escaping (Result<Output, Failure>) -> Void) -> AnyCancellable {
        self.convertToResult().sink(receiveValue: receiveValue)
    }
}

#endif
