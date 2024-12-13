import AppLibraryCommon
import AppLibraryStorage
import SwiftUI

struct SettingsTabLabel: View {
	private let category: SettingsCategory

	public init(category: SettingsCategory) {
		self.category = category
	}

	public var body: some View {
		Label {
			Text(category.titleKey, table: .settingsWindow)
		} icon: {
			category.icon
		}
	}
}

// MARK: -

private extension SettingsCategory {
	var titleKey: LocalizedStringKey {
		switch self {
			case .general: "TAB.GENERAL.TITLE"
			case .layout: "TAB.LAYOUT.TITLE"
			case .location: "TAB.LOCATION.TITLE"
			case .apps: "TAB.APPS.TITLE"
		}
	}

	var icon: Image {
		let systemName = switch self {
			case .general: Constant.Symbol.gearShape
			case .layout: Constant.Symbol.square_grid_3x3
			case .location: Constant.Symbol.externalDrive
			case .apps: Constant.Symbol.app
		}

		return Image(systemName: systemName)
	}
}
