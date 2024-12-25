public enum ApplicationGroupCriteria: String {
	case category
}

// MARK: - Sendable

extension ApplicationGroupCriteria: Sendable { }

// MARK: - Equatable

extension ApplicationGroupCriteria: Equatable { }

// MARK: - Hashable

extension ApplicationGroupCriteria: Hashable { }

// MARK: - Identifiable

extension ApplicationGroupCriteria: Identifiable {
	public var id: RawValue { rawValue }
}

// MARK: - Codable

extension ApplicationGroupCriteria: Codable { }
