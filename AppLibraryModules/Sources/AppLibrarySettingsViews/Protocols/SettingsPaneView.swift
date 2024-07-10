import AppLibraryStorage
import SwiftUI

protocol SettingsPaneView: View {
	associatedtype Model: SettingsFile
	associatedtype Content: View
	associatedtype Label: View

	var model: Model { get set }

	@ViewBuilder func makeLabel() -> Label

	@ViewBuilder func makeContent() -> Content
}

// MARK: - Default Implementation

extension SettingsPaneView {
	var body: some View {
		Form(content: makeContent)
			.onChange(of: model, model.save)
			.tabItem(makeLabel)
			.tag(Model.category)
	}
}
