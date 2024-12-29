import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryRuntimeModel
import AppLibraryStorage
import OSLog
import SwiftUI

struct ApplicationHideFlagsList: View {
	@Storage(apps: \.self) private var appsSettings
	@Storage(apps: \.applicationHideFlags) private var applicationHideFlags

	public init() { }

	public var body: some View {
		if applicationHideFlags.isEmpty {
			Text(.applicationHideFlagsList.list.emptyLabel)
				.foregroundStyle(.secondary)
		} else {
			listContent
		}
	}
}

// MARK: - Supporting Views

private extension ApplicationHideFlagsList {
	var listContent: some View {
		ForEach(ApplicationCache.shared.applications.keys) { applicationModelIdentifier in
			let activeFlags = Binding<ApplicationHideFlag.Set>(
				get: { applicationHideFlags[applicationModelIdentifier] ?? .none },
				set: { newValue in applicationHideFlags[applicationModelIdentifier] = newValue }
			)

			Item(
				applicationModelIdentifier: applicationModelIdentifier,
				selection: activeFlags
			)
			.id(applicationModelIdentifier)
		}
		.removeHideFlagsAction(removeHideFlags(for:))
	}
}

// MARK: - Functions

private extension ApplicationHideFlagsList {
	func removeHideFlags(for applicationModelIdentifier: ApplicationModelIdentifier) {
		appsSettings.removeApplicationHideFlags(for: applicationModelIdentifier)
	}
}