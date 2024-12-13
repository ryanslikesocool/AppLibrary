import AppLibraryStorage
import SwiftUI
internal import AppLibrarySettingsAppsPane
internal import AppLibrarySettingsLayoutPane
internal import AppLibrarySettingsGeneralPane
internal import AppLibrarySettingsLocationPane

struct SettingsTabContent: View {
	private let category: SettingsCategory

	public init(category: SettingsCategory) {
		self.category = category
	}

	public var body: some View {
		Form {
			switch category {
				case .general: GeneralPane()
				case .layout: LayoutPane()
				case .location: LocationPane()
				case .apps: AppsPane()
			}
		}
	}
}
