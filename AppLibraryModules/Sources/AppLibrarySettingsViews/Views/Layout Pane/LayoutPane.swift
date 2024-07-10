import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryStorage
import SwiftUI

struct LayoutPane: SettingsPaneView {
	typealias Model = LayoutSettings

	@ObservedObject var model: Model = .shared

	func makeLabel() -> some View {
		SwiftUI.Label("Layout", systemImage: Constant.Symbol.square_grid_3x3)
	}

	func makeContent() -> some View {
		LayoutPicker(selection: $model.layout)

		Section {
			GroupCriteriaPicker(selection: $model.groupCriteria)
		} header: {
			Text("Grouping")
			Text(#"Grouping is only available in the "Grid" layout."#)
		}
		.disabled(model.layout != .grid)

		Section {
			RecentlyAddedGroupToggle(isOn: $model.additionalGroups[.recentlyAdded])
			RecentlyUpdatedGroupToggle(isOn: $model.additionalGroups[.recentlyUpdated])
		} header: {
			Text("Additional Groups")
			Text(#"""
			Add additional groups to the top of the library.
			Grouping is only available in the "Grid" layout.
			"""#)
		}
		.disabled(model.layout != .grid)
	}
}
