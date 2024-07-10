public enum LibraryLayout: String {
	case list
	case grid
}

// MARK: - Hashable

extension LibraryLayout: Hashable { }

// MARK: - Identifiable

extension LibraryLayout: Identifiable {
	public var id: RawValue { rawValue }
}

// MARK: - Codable

extension LibraryLayout: Codable { }
