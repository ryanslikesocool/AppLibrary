public struct ApplicationHideFlags: OptionSet {
	public let rawValue: UInt8

	public init(rawValue: UInt8) {
		self.rawValue = rawValue
	}
}

// MARK: - Hashable

extension ApplicationHideFlags: Hashable { }

// MARK: - Codable

extension ApplicationHideFlags: Codable { }

// MARK: - CaseIterable

extension ApplicationHideFlags: CaseIterable {
	public static var allCases: [ApplicationHideFlags] = [.hiddenInBrowser, .hiddenInSearch]
}

// MARK: - Constants

public extension ApplicationHideFlags {
	static let hiddenInBrowser: Self = Self(rawValue: 1 << 0)
	static let hiddenInSearch: Self = Self(rawValue: 1 << 1)

	static let none: Self = Self(rawValue: 0)

	static let all: Self = [.hiddenInBrowser, .hiddenInSearch]
}
