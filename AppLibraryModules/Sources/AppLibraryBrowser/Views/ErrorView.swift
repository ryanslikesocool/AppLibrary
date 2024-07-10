import AppLibraryCommon
import AppLibraryCommonViews
import AppLibrarySettingsViews
import AppLibraryStorage
import OSLog
import SettingsAccess
import SwiftUI

struct ErrorView: View {
	@Environment(\.openSettingsLegacy) private var openSettings

	private let error: BrowserError?

	init(reason error: BrowserError?) {
		self.error = error
	}

	var body: some View {
		VStack {
			Image(systemName: Constant.Symbol.exclamationMark_octagon)
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
			case .some(.noSearchScopes):
				Text("No Search Scopes")
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
			case .some(.noSearchScopes):
				Text("Add search scopes in the settings pane.")
				settingsButton(destination: .apps)
			case .some(.noApps):
				Text("Add more search scopes in the settings pane.")
				settingsButton(destination: .apps)
			case .some(.allHidden):
				Text("Reveal apps in the settings pane.")
				settingsButton(destination: .apps)
			default:
				Button("Retry", systemImage: Constant.Symbol.arrow_clockwise, action: Event.refreshApps.send)
		}
	}

	func settingsButton(destination: SettingsCategory) -> some View {
		Button("Settings...", systemImage: Constant.Symbol.gear) {
			do {
				try openSettings()
				Event.goToSettingsTab(destination)
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
