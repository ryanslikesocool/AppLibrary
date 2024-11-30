import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryStorage
import SwiftUI

struct AppsPane: View {
	public init() { }
}

// MARK: - SettingsPaneView

extension AppsPane: SettingsPaneView {
	public static let category: SettingsCategory = .apps

	public func makeLabel() -> some View {
		SwiftUI.Label("Apps", systemImage: Constant.Symbol.app)
	}

	public func makeContent() -> some View {
		LabeledContent {
			RefreshAppsButton {
				SwiftUI.Label("Refresh", systemImage: Constant.Symbol.arrow_clockwise)
			}
		} label: {
			Text("Refresh")
			Text("Use ⌘ + R to refresh the list while the Library is focused.")
		}

		ApplicationHideFlagsList()
	}
}