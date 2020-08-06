// Copyright © 2020 Brian Drelling. All rights reserved.

import SwiftUI

// reference: https://www.hackingwithswift.com/quick-start/swiftui/how-to-use-dynamic-type-with-a-custom-font

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
struct CustomFont: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory

    var name: String
    var style: UIFont.TextStyle
    var weight: Font.Weight = .regular

    func body(content: Content) -> some View {
        content.font(
            Font.custom(self.name, size: UIFont.preferredFont(forTextStyle: self.style).pointSize)
                .weight(self.weight)
        )
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {
    func customFont(name: String,
                    style: UIFont.TextStyle,
                    weight: Font.Weight = .regular) -> some View
    {
        self.modifier(CustomFont(name: name, style: style, weight: weight))
    }
}

// MARK: Convenience

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
struct AppFont: RawRepresentable {
    let rawValue: String

    init(rawValue: String) {
        self.rawValue = rawValue
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension AppFont: ExpressibleByStringLiteral {
    init(stringLiteral: String) {
        self = AppFont(rawValue: stringLiteral)
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {
    func customFont(_ appFont: AppFont,
                    style: UIFont.TextStyle,
                    weight: Font.Weight = .regular) -> some View
    {
        self.modifier(CustomFont(name: appFont.rawValue, style: style, weight: weight))
    }
}
