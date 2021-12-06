// Copyright © 2021 Brian Drelling. All rights reserved.

#if canImport(UIKit)

import UIKit

public extension UIColor {
    func lighter(byPercentage percentage: CGFloat) -> UIColor {
        self.adjusted(byPercentage: abs(percentage))
    }

    func darker(byPercentage percentage: CGFloat) -> UIColor {
        self.adjusted(byPercentage: -1 * abs(percentage))
    }

    func adjusted(byPercentage percentage: CGFloat) -> UIColor {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        guard self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return .clear
        }

        return .init(
            red: min(red + percentage / 100, 1.0),
            green: min(green + percentage / 100, 1.0),
            blue: min(blue + percentage / 100, 1.0),
            alpha: alpha
        )
    }
}

#endif
