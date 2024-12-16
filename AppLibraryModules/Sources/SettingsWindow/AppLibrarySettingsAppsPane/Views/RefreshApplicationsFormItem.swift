import AppLibraryCommon
import AppLibraryCommonViews
import SwiftUI

struct RefreshApplicationsFormItem: View {
	public init() { }

	public var body: some View {
		LabeledContent {
			button
		} label: {
			Text("Refresh")
			Text("Use ⌘ + R to refresh the list while the Library is focused.")
		}
	}
}

// MARK: - Supporting Views

private extension RefreshApplicationsFormItem {
	var button: some View {
		RefreshAppsButton {
			Label {
				Text(.common.action.refresh)
			} icon: {
				Image(systemName: Constant.Symbol.arrow_clockwise)
			}
		}
	}
}
