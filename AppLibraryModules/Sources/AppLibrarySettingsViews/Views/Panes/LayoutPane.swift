import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryStorage
import SwiftUI

struct LayoutPane: View {
	@Storage(layout: \.layout) private var layout
	@Storage(layout: \.groupCriteria) private var groupCriteria
	@Storage(layout: \.additionalGroups) private var additionalGroups

	public init() { }
}

// MARK: - SettingsPaneView

extension LayoutPane: SettingsPaneView {
	public static let category: SettingsCategory = .layout

	public func makeLabel() -> some View {
		SwiftUI.Label("Layout", systemImage: Constant.Symbol.square_grid_3x3)
	}

	public func makeContent() -> some View {
		LibraryLayoutPicker()

		Section {
			ApplicationGroupCriteriaPicker(selection: $groupCriteria)
		} header: {
			Text("Grouping")
			Text(#"Grouping is only available in the "Grid" layout."#)
		}
		.disabled(layout != .grid)

		Section {
			RecentlyAddedGroupToggle(isOn: $additionalGroups[.recentlyAdded])
			RecentlyUpdatedGroupToggle(isOn: $additionalGroups[.recentlyUpdated])
		} header: {
			Text("Additional Groups")
			Text(#"""
			Add additional groups to the top of the library.
			Grouping is only available in the "Grid" layout.
			"""#)
		}
		.disabled(layout != .grid)
	}
}