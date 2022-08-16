// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

extension LocalStore {
    static let mocked: Self = .init(store: UserDefaults(suiteName: "com.kipple.mocked") ?? .standard)
}
