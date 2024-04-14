public enum SettingsTab: UInt8 {
	case display
	case directories
	case apps
}

// MARK: - Sendable

extension SettingsTab: Sendable { }

// MARK: - Equatable

extension SettingsTab: Equatable { }

// MARK: - Hashable

extension SettingsTab: Hashable { }

// MARK: - Identifiable

extension SettingsTab: Identifiable {
	public var id: RawValue { rawValue }
}

// MARK: - CustomStringConvertible

extension SettingsTab: CustomStringConvertible {
	public var description: String {
		switch self {
			case .display: "Display"
			case .directories: "Directories"
			case .apps: "Apps"
		}
	}
}

// MARK: - CaseIterable

extension SettingsTab: CaseIterable { }

// MARK: -

extension SettingsTab {
	var symbolName: String {
		switch self {
			case .display: "display"
			case .directories: "folder"
			case .apps: "app"
		}
	}
}
