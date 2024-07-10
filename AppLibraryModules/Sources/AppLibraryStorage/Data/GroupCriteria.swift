public enum GroupCriteria: String {
	case category
}

// MARK: - Hashable

extension GroupCriteria: Hashable { }

// MARK: - Identifiable

extension GroupCriteria: Identifiable {
	public var id: RawValue { rawValue }
}

// MARK: - Codable

extension GroupCriteria: Codable { }
