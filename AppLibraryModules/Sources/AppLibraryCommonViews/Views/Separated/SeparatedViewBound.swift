public struct SeparatedViewBound: OptionSet {
	public let rawValue: UInt8

	public init(rawValue: RawValue) {
		self.rawValue = rawValue
	}
}

// MARK: - Sendable

extension SeparatedViewBound: Sendable { }

// MARK: - Equatable

extension SeparatedViewBound: Equatable { }

// MARK: - Hashable

extension SeparatedViewBound: Hashable { }

// MARK: - Constants

public extension SeparatedViewBound {
	/// Don't include any bound separators.
	static let none: Self = Self(rawValue: 0)

	/// Include the leading bound separator.
	static let leading: Self = Self(rawValue: 1 << 0)

	/// Include the trailing bound separator.
	static let trailing: Self = Self(rawValue: 1 << 1)

	/// Include all bound separators.
	static let all: Self = [.leading, .trailing]
}
