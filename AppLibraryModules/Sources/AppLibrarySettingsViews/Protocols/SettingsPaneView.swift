import AppLibraryStorage
import SwiftUI

protocol SettingsPaneView: View {
	associatedtype Content: View
	associatedtype Label: View

	static var category: SettingsCategory { get }

	@ViewBuilder func makeLabel() -> Label

	@ViewBuilder func makeContent() -> Content
}

// MARK: - Default Implementation

extension SettingsPaneView {
	var body: some View {
		Form(content: makeContent)
			.tabItem(makeLabel)
			.tag(Self.category)
	}
}
