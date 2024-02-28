// Copyright © 2024 Brian Drelling. All rights reserved.

import Foundation

extension UserDefaults {
    static let mocked: UserDefaults = {
        let name = "com.kipple.mocked"
        let store = UserDefaults(suiteName: name)!
        store.removePersistentDomain(forName: name)

        return store
    }()
}
