import AppLibraryCommon
import AppLibraryResources
import SFSymbolToolbox
import SwiftUI

/// A button that opens the browser window.
public struct BrowserWindowLink: View {
	public init() { }

	public var body: some View {
		WindowLink(id: Self.windowID) {
			Text(
				LocalizedStringResource.settingsWindow.title
			)
		}
	}
}

// MARK: - Constants

private extension BrowserWindowLink {
	static let windowID: WindowIdentifier = .about
}
