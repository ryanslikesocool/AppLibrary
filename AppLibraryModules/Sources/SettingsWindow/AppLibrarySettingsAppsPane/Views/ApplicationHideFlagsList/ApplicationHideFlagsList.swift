import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryStorage
import LocalizationTable
import OSLog
import SwiftUI

struct ApplicationHideFlagsList: View {
	@Storage(apps: \.self) private var appsSettings
	@Storage(apps: \.applicationHideFlags) private var applicationHideFlags

	public init() { }

	public var body: some View {
		if applicationHideFlags.isEmpty {
			Text("LIST.EMPTY_LABEL", table: .applicationHideFlagsList)
				.foregroundStyle(.secondary)
		} else {
			listContent
		}
	}
}

// MARK: - Supporting Views

private extension ApplicationHideFlagsList {
	var listContent: some View {
		ForEach(applicationHideFlags.keys.sorted(by: \.displayName)) { application in
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
}
