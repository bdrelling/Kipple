// Copyright © 2024 Brian Drelling. All rights reserved.

import Combine
import KippleCombine
import XCTest

final class PublisherExtensionTests: XCTestCase {
    private var cancellables: Set<AnyCancellable> = []

    func testSinkResultSuccess() {
        let expectation = XCTestExpectation(description: "Success case of sinkResult")
        let publisher = Just("Test").setFailureType(to: Error.self)

        publisher
            .sinkResult { result in
                switch result {
                case let .success(value):
                    XCTAssertEqual(value, "Test")
                    expectation.fulfill()
                case .failure:
                    XCTFail("Expected success but received failure")
                }
            }
            .store(in: &self.cancellables)

        wait(for: [expectation], timeout: 1)
    }

    func testSinkResultFailure() {
        let expectation = XCTestExpectation(description: "Failure case of sinkResult")
        let error = NSError(domain: "TestError", code: -1, userInfo: nil)
        let publisher = Fail<String, Error>(error: error)

        publisher
            .sinkResult { result in
                switch result {
                case .success:
                    XCTFail("Expected failure but received success")
                case let .failure(receivedError):
                    XCTAssertEqual(receivedError as NSError, error)
                    expectation.fulfill()
                }
            }
            .store(in: &self.cancellables)

        wait(for: [expectation], timeout: 1)
    }
}
