public enum LibraryLayout: String {
	case list
	case grid
}

// MARK: - Equatable

extension LibraryLayout: Equatable { }

// MARK: - Hashable

extension LibraryLayout: Hashable { }

// MARK: - Identifiable

extension LibraryLayout: Identifiable {
	public var id: RawValue { rawValue }
}

// MARK: - Codable

extension LibraryLayout: Codable { }
