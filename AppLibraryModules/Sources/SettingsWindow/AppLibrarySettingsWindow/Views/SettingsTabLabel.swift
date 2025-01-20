import AppLibraryStorage
import SFSymbolToolbox
import SwiftUI

struct SettingsTabLabel: View {
	private let category: SettingsCategory

	public init(category: SettingsCategory) {
		self.category = category
	}

	public var body: some View {
		Label(
			String(localized: category.localizedStringResource),
			systemImage: category.systemSymbolName
		)
	}
}
