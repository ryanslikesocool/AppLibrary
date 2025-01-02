import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryStorage
import SFSymbolToolbox
import SwiftUI

struct SettingsTabLabel: View {
	private let category: SettingsCategory

	public init(category: SettingsCategory) {
		self.category = category
	}

	public var body: some View {
		Label(String(localized: category.titleKey), systemImage: category.icon)
	}
}

// MARK: -

private extension SettingsCategory {
	var titleKey: LocalizedStringResource {
		switch self {
			case .general: .settingsWindow.category.general
			case .layout: .settingsWindow.category.layout
			case .apps: .settingsWindow.category.apps
		}
	}

	var icon: SystemSymbol {
		switch self {
			case .general: .gearShape
			case .layout: .square_grid_3x3
			case .apps: .app
		}
	}
}
