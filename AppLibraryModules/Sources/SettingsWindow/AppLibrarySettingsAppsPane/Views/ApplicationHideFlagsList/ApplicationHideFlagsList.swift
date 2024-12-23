import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryStorage
import OSLog
import SwiftUI

struct ApplicationHideFlagsList: View {
	@Storage(apps: \.self) private var appsSettings
	@Storage(apps: \.applicationHideFlags) private var applicationHideFlags

	private var listItems: some RandomAccessCollection<ApplicationModelIdentifier> {
		applicationHideFlags.keys
			.sorted(using: .model(by: \.displayName, comparator: .localizedStandard))
	}

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
		ForEach(listItems) { applicationModelIdentifier in
			let activeFlags = Binding<ApplicationHideFlag.Set>(
				get: { applicationHideFlags[applicationModelIdentifier] ?? .none },
				set: { newValue in applicationHideFlags[applicationModelIdentifier] = newValue }
			)

			Item(
				application: applicationModelIdentifier,
				selection: activeFlags,
				onRemove: { appsSettings.removeApplicationHideFlags(for: applicationModelIdentifier) }
			)
			.id(applicationModelIdentifier)
		}
	}
}
