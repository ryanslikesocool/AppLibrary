import SwiftUI

protocol SettingsPaneView: View {
	associatedtype Settings: SettingsFile
	associatedtype Content: View

	var model: Settings { get set }

	@ViewBuilder var content: Content { get }
	var tabLabel: Label<Text, Image> { get }
}

// MARK: - Default Implementation

extension SettingsPaneView {
	var body: some View {
		Form {
			content
		}
		.tabItem { tabLabel }
		.onChange(of: model) { newValue in
			newValue.save()
		}
	}
}
