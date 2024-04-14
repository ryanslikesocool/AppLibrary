import AppLibraryStorage
import SwiftUI

extension LayoutPane {
	struct GroupingSection: View {
		@Binding var model: AppSettings.Layout

		var body: some View {
			Section {
				groupByCategoryToggle
				recentlyAddedGroupToggle
				recentlyUpdatedGroupToggle
			} header: {
				sectionHeader
			}
			.disabled(model.layout != .grid)
		}
	}
}

// MARK: - Supporting Views

private extension LayoutPane.GroupingSection {
	@ViewBuilder var sectionHeader: some View {
		Text("Grouping")
		Text("Grouping is only available in the \"Grid\" layout.")
	}

	var groupByCategoryToggle: some View {
		Toggle("Group by Category", isOn: $model.groupByCategory)
	}

	var recentlyAddedGroupToggle: some View {
		Toggle(isOn: $model.recentlyAddedGroup) {
			Text("Recently Added Group")
			Text("Adds a group at the top of the library with apps that have been added in the last week.")
		}
	}

	var recentlyUpdatedGroupToggle: some View {
		Toggle(isOn: $model.recentlyUpdatedGroup) {
			Text("Recently Updated Group")
			Text("Adds a group at the top of the library with apps that have been updated in the last week.")
		}
	}
}
