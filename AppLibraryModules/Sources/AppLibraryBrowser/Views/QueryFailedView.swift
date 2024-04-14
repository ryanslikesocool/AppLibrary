import AppLibraryCommon
import AppLibrarySettings
import OSLog
import SettingsAccess
import SwiftUI

struct QueryFailedView: View {
	@Environment(\.openSettings) private var openSettings

	private let error: MetadataQueryError?

	init(reason error: MetadataQueryError?) {
		self.error = error
	}

	var body: some View {
		VStack {
			Image(systemName: "exclamationmark.octagon")
				.resizable()
				.fontWeight(.semibold)
				.frame(width: 48, height: 48)
				.padding(.horizontal, 32)

			errorTitle
				.font(.title)
				.fontWeight(.semibold)
			recoveryLabel
		}
		.multilineTextAlignment(.center)
		.foregroundStyle(.secondary)
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.padding()
	}
}

// MARK: - Supporting View

private extension QueryFailedView {
	@ViewBuilder var errorTitle: some View {
		switch error {
			case .some(.noSearchDirectories):
				Text("No Search Directories")
			default:
				Text("Failed to Load Apps")
		}
	}

	@ViewBuilder var recoveryLabel: some View {
		switch error {
			case .some(.noSearchDirectories):
				Text("Add search directories from the settings pane.")
				Button("Settings...", systemImage: "gear") {
					do {
						try openSettings()
						Event.goToSettingsTab.send(SettingsTab.directories)
					} catch {
						Logger.module.error("""
						Failed to open settings window:
						\(error.localizedDescription)
						""")
					}
				}
			default:
				Button("Retry", systemImage: "arrow.clockwise", action: Event.refreshApps.send)
		}
	}
}
