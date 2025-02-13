import AppLibraryCommon
import AppLibraryResources
import SFSymbolToolbox
import SwiftUI

/// A button that opens the settings window.
public struct SettingsWindowLink: View {
	@Environment(\.openWindow) public var openWindow

	public nonisolated init() { }

	public var body: some View {
		WindowLink(id: Self.windowID) {
			Label(
				LocalizedStringResource.settingsWindow.title,
				systemImage: SystemSymbolName.gearShape.rawValue
			)
		}
	}
}

// MARK: - Constants

private extension SettingsWindowLink {
	static let windowID: WindowIdentifier = .settings
}
