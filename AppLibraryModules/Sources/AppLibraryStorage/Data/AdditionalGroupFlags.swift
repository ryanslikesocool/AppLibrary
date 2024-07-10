public struct AdditionalGroupFlags: OptionSet {
	public let rawValue: UInt8

	public init(rawValue: UInt8) {
		self.rawValue = rawValue
	}
}

// MARK: - Hashable

extension AdditionalGroupFlags: Hashable { }

// MARK: - Codable

extension AdditionalGroupFlags: Codable { }

// MARK: - Constants

public extension AdditionalGroupFlags {
	static let recentlyAdded: Self = Self(rawValue: 1 << 0)
	static let recentlyUpdated: Self = Self(rawValue: 1 << 1)

	static let all: Self = [.recentlyAdded, .recentlyUpdated]
}
