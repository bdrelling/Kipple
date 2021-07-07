// Copyright © 2021 Brian Drelling. All rights reserved.

import Combine
import FirebaseFirestore

// Sourced from https://github.com/rever-ai/CombineFirebase
public extension WriteBatch {
    func commit() -> AnyPublisher<Void, Error> {
        Future<Void, Error> { [weak self] promise in
            self?.commit { error in
                guard let error = error else {
                    promise(.success(()))
                    return
                }
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
}
