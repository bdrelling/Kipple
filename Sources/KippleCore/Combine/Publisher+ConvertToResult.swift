// Copyright © 2021 Brian Drelling. All rights reserved.

import Combine

// TODO: Migrate to Kipple
public extension Publisher {
    func convertToResult() -> AnyPublisher<Result<Output, Failure>, Never> {
        self.map(Result.success)
            .catch { Just(.failure($0)) }
            .eraseToAnyPublisher()
    }
}
