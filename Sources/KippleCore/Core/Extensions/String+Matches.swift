// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

public extension String {
    func matches(for pattern: String, range: NSRange? = nil) -> [String] {
        let range = range ?? NSRange(self.startIndex..., in: self)

        let matches = try? NSRegularExpression(pattern: pattern)
            .matches(in: self, range: range)

        return matches?.compactMap {
            if let matchRange = Range($0.range, in: self) {
                return String(self[matchRange])
            } else {
                return nil
            }
        } ?? []
    }

    func firstMatch(for pattern: String, range: NSRange? = nil) -> String? {
        self.matches(for: pattern, range: range).first
    }
}
