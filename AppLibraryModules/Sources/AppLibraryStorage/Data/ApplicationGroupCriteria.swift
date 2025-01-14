public enum ApplicationGroupCriteria: String {
	// Categorize apps by App Store category type.
	case category

	// Categorize apps by developer.
//	case developer
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
