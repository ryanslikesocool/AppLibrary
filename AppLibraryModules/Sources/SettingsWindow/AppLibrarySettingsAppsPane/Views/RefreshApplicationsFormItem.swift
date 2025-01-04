import AppLibraryCommon
import AppLibraryCommonViews
import SwiftUI

struct RefreshApplicationsFormItem: View {
	public init() { }

	public var body: some View {
		LabeledContent {
			button
		} label: {
			Text(.applicationRefresh.label)
			Text(.applicationRefresh.description)
		}
	}
}

// MARK: - Supporting Views

private extension RefreshApplicationsFormItem {
	var button: some View {
		RefreshAppsButton {
			Label(
				String(localized: .common.action.refresh),
				systemImage: .arrow_clockwise
			)
		}
	}
}
