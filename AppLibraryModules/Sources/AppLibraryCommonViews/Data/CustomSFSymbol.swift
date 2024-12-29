@frozen
public struct CustomSFSymbol: RawRepresentable {
	public let rawValue: String

	public init(rawValue: RawValue) {
		self.rawValue = rawValue
	}
}

// MARK: - Sendable

extension CustomSFSymbol: Sendable { }

// MARK: - ExpressibleByStringLiteral

extension CustomSFSymbol: ExpressibleByStringLiteral {
	public init(stringLiteral value: StringLiteralType) {
		self.init(rawValue: value)
	}
}

// MARK: - Constants

public extension CustomSFSymbol {
	static let finder: Self = "finder"
}