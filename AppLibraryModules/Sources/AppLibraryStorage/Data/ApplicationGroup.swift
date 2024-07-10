public struct ApplicationGroup: RawRepresentable {
	public let rawValue: String

	public init(rawValue: String) {
		self.rawValue = rawValue
	}
}

// MARK: - Sendable

extension ApplicationGroup: Sendable { }

// MARK: - Equatable

extension ApplicationGroup: Equatable { }

// MARK: - Hashable

extension ApplicationGroup: Hashable { }

// MARK: - Identifiable

extension ApplicationGroup: Identifiable {
	public var id: RawValue { rawValue }
}

// MARK: - ExpressibleByStringLiteral

extension ApplicationGroup: ExpressibleByStringLiteral {
	public init(stringLiteral value: RawValue.StringLiteralType) {
		self.init(rawValue: value)
	}
}
