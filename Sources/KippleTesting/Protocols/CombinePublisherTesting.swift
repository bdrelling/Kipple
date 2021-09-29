// Copyright © 2021 Brian Drelling. All rights reserved.

import Combine
import Foundation
import XCTest

public protocol CombinePublisherTesting: XCTestCase {
    var defaultTimeout: TimeInterval { get }
    var subscriptions: Set<AnyCancellable> { get set }
}
