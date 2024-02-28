// Copyright © 2024 Brian Drelling. All rights reserved.

import Foundation

// TODO: This might not belong in this module?
extension Data {
    var asPrettyPrintedJSON: String? {
        guard
            let object = try? JSONSerialization.jsonObject(with: self, options: []),
            let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]) else {
            return nil
        }

        return String(data: data, encoding: .utf8)
    }
}
