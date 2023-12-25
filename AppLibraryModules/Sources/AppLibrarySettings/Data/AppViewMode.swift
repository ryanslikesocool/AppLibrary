public enum AppViewMode: String, Hashable, Codable, CaseIterable, Sendable {
	case list
	case grid
}

// MARK: - Identifiable

extension AppViewMode: Identifiable {
	public var id: String { rawValue }
}

// MARK: - CustomStringConvertible

extension AppViewMode: CustomStringConvertible {
	public var description: String { rawValue.capitalized }
}
