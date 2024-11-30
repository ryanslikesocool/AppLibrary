public enum ApplicationHideFlag: UInt8 {
	case hiddenInBrowser
	case hiddenInSearch
}

// MARK: - Equatable

extension ApplicationHideFlag: Equatable { }

// MARK: - Hashable

extension ApplicationHideFlag: Hashable { }

// MARK: - Identifiable

extension ApplicationHideFlag: Identifiable {
	public var id: RawValue { rawValue }
}

// MARK: - Codable

extension ApplicationHideFlag: Codable { }