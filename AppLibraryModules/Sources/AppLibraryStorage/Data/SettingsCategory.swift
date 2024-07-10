public enum SettingsCategory: String {
	case general
	case layout
	case location
	case apps
}

// MARK: - Hashable

extension SettingsCategory: Hashable { }

// MARK: - Identifiable

extension SettingsCategory: Identifiable {
	public var id: RawValue { rawValue }
}
