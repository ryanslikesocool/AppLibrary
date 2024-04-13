public enum AppViewMode: UInt8 {
	case list
	case grid
}

// MARK: - Sendable

extension AppViewMode: Sendable { }

// MARK: - Equatable

extension AppViewMode: Equatable { }

// MARK: - Hashable

extension AppViewMode: Hashable { }

// MARK: - Codable

extension AppViewMode: Codable { }

// MARK: - Identifiable

extension AppViewMode: Identifiable {
	public var id: RawValue { rawValue }
}

// MARK: - CustomStringConvertible

extension AppViewMode: CustomStringConvertible {
	public var description: String {
		switch self {
			case .list: "List"
			case .grid: "Grid"
		}
	}
}

// MARK: - CaseIterable

extension AppViewMode: CaseIterable { }
