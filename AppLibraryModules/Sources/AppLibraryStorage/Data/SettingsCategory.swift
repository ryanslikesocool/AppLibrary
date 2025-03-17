import AppLibraryResources
import Foundation
import SFSymbolToolbox

public enum SettingsCategory: String {
	case general
	case layout
	case apps
}

// MARK: - Sendable

extension SettingsCategory: Sendable { }

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

// MARK: - CustomLocalizedStringResourceConvertible

extension SettingsCategory: CustomLocalizedStringResourceConvertible {
	public var localizedStringResource: LocalizedStringResource {
		switch self {
			case .general: .settingsWindow.category.general.title
			case .layout: .settingsWindow.category.layout.title
			case .apps: .settingsWindow.category.apps.title
		}
	}
}

// MARK: -

public extension SettingsCategory {
	var systemSymbolName: SystemSymbolName {
		switch self {
			case .general: .gearShape
			case .layout: .square_grid_3x3
			case .apps: .app
		}
	}
}
