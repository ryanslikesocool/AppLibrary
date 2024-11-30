public enum SettingsCategory: String {
	case general
	case layout
	case location
	case apps
}

// MARK: - Equatable

extension SettingsCategory: Equatable { }

// MARK: - Hashable

extension SettingsCategory: Hashable { }

// MARK: - Identifiable

extension SettingsCategory: Identifiable {
	public var id: RawValue { rawValue }
}

// MARK: - CaseIterable

extension SettingsCategory: CaseIterable { }