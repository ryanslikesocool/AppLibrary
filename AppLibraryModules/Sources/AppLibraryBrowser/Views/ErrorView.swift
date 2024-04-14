import AppLibraryCommon
import AppLibrarySettings
import OSLog
import SettingsAccess
import SwiftUI

struct ErrorView: View {
	@Environment(\.openSettings) private var openSettings

	private let error: BrowserError?

	init(reason error: BrowserError?) {
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

private extension ErrorView {
	@ViewBuilder var errorTitle: some View {
		switch error {
			case .some(.noSearchDirectories):
				Text("No Search Directories")
			case .some(.noApps):
				Text("No Apps")
			case .some(.allHidden):
				Text("All Apps Hidden")
			default:
				Text("Failed to Load Apps")
		}
	}

	@ViewBuilder var recoveryLabel: some View {
		switch error {
			case .some(.noSearchDirectories):
				Text("Add search directories in the settings pane.")
				settingsButton(destination: .directories)
			case .some(.noApps):
				Text("Add more search directories in the settings pane.")
				settingsButton(destination: .directories)
			case .some(.allHidden):
				Text("Reveal apps in the settings pane.")
				settingsButton(destination: .apps)
			default:
				Button("Retry", systemImage: "arrow.clockwise", action: Event.refreshApps.send)
		}
	}

	func settingsButton(destination: SettingsTab) -> some View {
		Button("Settings...", systemImage: "gear") {
			do {
				try openSettings()
				Event.goToSettingsTab.send(destination)
			} catch {
				Logger.module.error("""
				Failed to open settings window:
				\(error.localizedDescription)
				""")
			}
		}
		.controlSize(.large)
	}
}
