import AppLibraryStorage
import SwiftUI

extension DisplayPane {
	struct GroupingSection: View {
		@Binding var model: AppSettings.Display

		var body: some View {
			Section {
				categoryGroupToggle
			} header: {
				sectionHeader
			}
		}
	}
}

// MARK: - Supporting Views

private extension DisplayPane.GroupingSection {
	@ViewBuilder var sectionHeader: some View {
		Text("Grouping")
		Text("Grouping is only available in the \"Grid\" Library Layout.")
	}

	var categoryGroupToggle: some View {
		Toggle("Group by Category", isOn: $model.autoGroup)
			.disabled(model.libraryLayout == .list)
	}
}
