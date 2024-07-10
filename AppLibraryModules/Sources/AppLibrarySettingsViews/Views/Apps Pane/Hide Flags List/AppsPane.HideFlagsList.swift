import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryStorage
import SwiftUI

extension AppsPane {
	struct HideFlagsList: View {
		@ObservedObject var model: AppsSettings
		@Binding var selection: [ApplicationIdentifier: ApplicationHideFlags]

		var body: some View {
			Section {
				if selection.isEmpty {
					emptyListLabel
				} else {
					listContent
				}
			} header: {
				sectionHeader
			}
		}
	}
}

// MARK: - Supporting Views

private extension AppsPane.HideFlagsList {
	var emptyListLabel: some View {
		Text("No hidden apps...")
			.foregroundStyle(.secondary)
	}

	var listContent: some View {
		ForEach(selection.keys.sorted()) { application in
			Item(model: model, application: application)
				.id(application)
		}
	}

	@ViewBuilder var sectionHeader: some View {
		Text("Hide Flags")
		Text("""
		Apps listed here will not appear in the Library.
		Apps can be hidden by right-clicking in the Library and selecting "Hide".
		""")
	}
}
