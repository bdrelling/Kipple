// Copyright © 2024 Brian Drelling. All rights reserved.

public struct SemanticVersion: Equatable, Hashable, Codable {
    // MARK: Properties

    public let major: Int
    public let minor: Int
    public let patch: Int

    // MARK: Initializers

    public init(major: Int, minor: Int, patch: Int) {
        self.major = major
        self.minor = minor
        self.patch = patch
    }
}

// MARK: - Extensions

extension SemanticVersion: RawRepresentable {
    public var rawValue: String {
        "\(self.major).\(self.minor).\(self.patch)"
    }

    public init(rawValue: String) {
        let versionParts = rawValue.split(separator: ".")

        switch versionParts.count {
        case 3:
            guard let major = Int(versionParts[0]),
                  let minor = Int(versionParts[1]),
                  let patch = Int(versionParts[2]) else {
                self = .zero
                return
            }

            self.major = major
            self.minor = minor
            self.patch = patch
        case 2:
            guard let major = Int(versionParts[0]),
                  let minor = Int(versionParts[1]) else {
                self = .zero
                return
            }

            self.major = major
            self.minor = minor
            self.patch = 0
        default:
            self = .zero
        }
    }
}

extension SemanticVersion: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self.init(rawValue: value)
    }
}

public extension SemanticVersion {
    static let zero: Self = .init(major: 0, minor: 0, patch: 0)

    static func from(_ versionString: String) -> Self {
        .init(stringLiteral: versionString)
    }
}
