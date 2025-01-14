import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryRuntimeModel
import AppLibraryRuntimeModelViews
import AppLibraryStorage
import OSLog
import SwiftUI

struct ApplicationVisibilityList: View {
	@Storage(apps: \.self) private var appsSettings
	@Storage(apps: \.applicationVisibilityFlags) private var applicationVisibilityFlags

	public init() { }

	public var body: some View {
		if applicationVisibilityFlags.isEmpty {
			Text(.applicationVisibilityList.list.emptyLabel)
				.foregroundStyle(.secondary)
		} else {
			listContent
		}
	}
}

// MARK: - Supporting Views

private extension ApplicationVisibilityList {
	var listContent: some View {
		SwiftUI.List(ApplicationCache.shared.applications.keys) { applicationModelIdentifier in
			let activeFlags = Binding<ApplicationVisibility.Set>(
				get: { applicationVisibilityFlags[applicationModelIdentifier, default: .all] },
				set: { newValue in applicationVisibilityFlags[applicationModelIdentifier] = newValue }
			)

			Item(selection: activeFlags)
				.id(applicationModelIdentifier)
				.applicationModelIdentifier(applicationModelIdentifier)
		}
		.removeVisibilityFlagsAction(removeVisibilityFlags(for:))
		.listStyle(.inset)
	}
}

// MARK: - Functions

private extension ApplicationVisibilityList {
	func removeVisibilityFlags(for applicationModelIdentifier: ApplicationModelIdentifier) {
		appsSettings.removeApplicationVisibilityFlags(for: applicationModelIdentifier)
	}
}
