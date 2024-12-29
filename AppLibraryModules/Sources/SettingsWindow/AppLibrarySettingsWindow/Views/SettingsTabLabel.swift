import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryStorage
import SwiftUI

struct SettingsTabLabel: View {
	private let category: SettingsCategory

	public init(category: SettingsCategory) {
		self.category = category
	}

	public var body: some View {
		Label(category.titleKey, systemImage: category.icon)
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

	var icon: SFSymbol {
		switch self {
			case .general: SFSymbol.gearShape
			case .layout: SFSymbol.square_grid_3x3
			case .apps: SFSymbol.app
		}
	}
}
