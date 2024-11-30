import AppLibraryCommon
import OSLog
import AppLibraryCommonViews
import AppLibraryStorage
import SwiftUI

struct ApplicationHideFlagsList: View {
	@Storage(apps: \.self) private var appsSettings
	@Storage(apps: \.applicationHideFlags) private var applicationHideFlags

	public init() { }

	public var body: some View {
		Section {
			if applicationHideFlags.isEmpty {
				emptyListLabel
			} else {
				listContent
			}
		} header: {
			sectionHeader
		}
	}
}

// MARK: - Supporting Views

private extension ApplicationHideFlagsList {
	var emptyListLabel: some View {
		Text("No hidden apps...")
			.foregroundStyle(.secondary)
	}

	var listContent: some View {
		ForEach(applicationHideFlags.keys.sorted()) { application in
			let activeFlags = Binding<ApplicationHideFlag.Set>(
				get: { applicationHideFlags[application] ?? .none },
				set: { newValue in applicationHideFlags[application] = newValue }
			)

			Item(
				application: application,
				selection: activeFlags,
				onRemove: { appsSettings.removeApplicationHideFlags(for: application) }
			)
			.id(application)
		}
	}

	@ViewBuilder
	var sectionHeader: some View {
		Text("Hide Flags")
		Text("""
		Apps listed here will not appear in the Library.
		Apps can be hidden by right-clicking in the Library and selecting "Hide".
		""")
	}
}
