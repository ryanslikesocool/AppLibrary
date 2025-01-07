import AppLibraryCommon
import AppLibraryCommonViews
import SwiftUI

struct RefreshApplicationsFormItem: View {
	public init() { }

	public var body: some View {
		LabeledContent {
			RefreshButton()
		} label: {
			Text(.applicationRefresh.label)
			Text(.applicationRefresh.description)
		}
	}
}
