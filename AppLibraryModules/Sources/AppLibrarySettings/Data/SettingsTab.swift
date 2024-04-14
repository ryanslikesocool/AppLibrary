public enum SettingsTab: UInt8 {
	case display
	case layout
	case discovery
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
			case .layout: "Layout"
			case .discovery: "Discovery"
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
			case .layout: "square.grid.3x3"
			case .discovery: "magnifyingglass"
			case .apps: "app"
		}
	}
}
