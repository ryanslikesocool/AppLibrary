import AppLibraryStorage
import SwiftUI

protocol SettingsPaneView: View {
	associatedtype Settings: SettingsFile
	associatedtype Content: View

	static var tab: SettingsTab { get }

	var model: Settings { get set }

	@ViewBuilder var content: Content { get }
}

// MARK: - Default Implementation

extension SettingsPaneView {
	var body: some View {
		Form {
			content
		}
		.tabItem { tabLabel }
		.onChange(of: model) {
			model.save()
		}
	}

	var tabLabel: Label<Text, Image> {
		Label(Self.tab.description, systemImage: Self.tab.symbolName)
	}
}
