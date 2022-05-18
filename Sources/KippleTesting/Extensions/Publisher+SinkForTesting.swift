// Copyright © 2022 Brian Drelling. All rights reserved.

import Combine
import XCTest

public extension Publisher {
    // TODO: Delete?
    func sink(with expectation: XCTestExpectation, receiveValue: @escaping (Self.Output) -> Void) -> AnyCancellable {
        self.sinkForTesting(with: expectation, receiveValue: receiveValue)
    }

    // TODO: Delete?
    func fulfill(_ expectation: XCTestExpectation) -> AnyCancellable {
        self.sinkForTesting(with: expectation)
    }

    /// A convenience method for testing Combine `sink` operations that automatically
    /// fulfills a given expectation when the operation is completed.
    private func sinkForTesting(with expectation: XCTestExpectation, receiveValue: ((Self.Output) -> Void)? = nil) -> AnyCancellable {
        self.sink { completion in
            switch completion {
            case let .failure(error):
                XCTFail(error.localizedDescription)
            case .finished:
                break
            }

            expectation.fulfill()
        } receiveValue: { value in
            receiveValue?(value)
        }
    }
}
