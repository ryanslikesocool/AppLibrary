public struct ApplicationIdentifier {
	public let bundleIdentifier: String
	public let displayName: String

	public init(_ bundleIdentifier: String, named displayName: String) {
		self.bundleIdentifier = bundleIdentifier
		self.displayName = displayName
	}
}

// MARK: - Equatable

extension ApplicationIdentifier: Equatable {
	public static func == (lhs: Self, rhs: Self) -> Bool {
		lhs.bundleIdentifier == rhs.bundleIdentifier
		// NOTE: displayName is intentionally not used for equality.
	}
}

// MARK: - Hashable

extension ApplicationIdentifier: Hashable {
	public func hash(into hasher: inout Hasher) {
		hasher.combine(bundleIdentifier)
		// NOTE: displayName is intentionally not hashed.
	}
}

// MARK: - Identifiable

extension ApplicationIdentifier: Identifiable {
	public var id: String { bundleIdentifier }
}

// MARK: - Codable

extension ApplicationIdentifier: Codable { }

// MARK: - Comparable

extension ApplicationIdentifier: Comparable {
	public static func < (lhs: Self, rhs: Self) -> Bool {
		lhs.displayName.localizedStandardCompare(rhs.displayName) == .orderedAscending
	}
}
