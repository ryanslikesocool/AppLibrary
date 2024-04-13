public enum LibraryLayout: UInt8 {
	case list
	case grid
}

// MARK: - Sendable

extension LibraryLayout: Sendable { }

// MARK: - Equatable

extension LibraryLayout: Equatable { }

// MARK: - Hashable

extension LibraryLayout: Hashable { }

// MARK: - Codable

extension LibraryLayout: Codable { }

// MARK: - Identifiable

extension LibraryLayout: Identifiable {
	public var id: RawValue { rawValue }
}

// MARK: - CustomStringConvertible

extension LibraryLayout: CustomStringConvertible {
	public var description: String {
		switch self {
			case .list: "List"
			case .grid: "Grid"
		}
	}
}

// MARK: - CaseIterable

extension LibraryLayout: CaseIterable { }
