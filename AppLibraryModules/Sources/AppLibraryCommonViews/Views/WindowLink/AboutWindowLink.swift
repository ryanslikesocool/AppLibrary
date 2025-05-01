import AppLibraryCommon
import AppLibraryResources
import SFSymbolToolbox
import SwiftUI

/// A button that opens the about window.
public struct AboutWindowLink: View {
	public nonisolated init() { }

	public var body: some View {
		WindowLink(id: Self.windowID) {
			Label(
				LocalizedStringResource.aboutWindow.title,
				systemImage: .info_circle
			)
		}
	}
}

// MARK: - Constants

private extension AboutWindowLink {
	static let windowID: WindowIdentifier = .about
}
