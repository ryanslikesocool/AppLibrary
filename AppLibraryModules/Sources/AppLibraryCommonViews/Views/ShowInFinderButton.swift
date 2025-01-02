import AppLibraryCommon
import AppLibraryResources
import SwiftUI

public struct ShowInFinderButton: View {
	private let url: URL?

	public init(_ url: URL?) {
		self.url = url
	}

	public var body: some View {
		Button(action: buttonAction) {
			Label(String(localized: .common.action.showInFinder), image: .finder)
		}
		.disabled(url == nil)
	}
}

// MARK: - Functions

private extension ShowInFinderButton {
	func buttonAction() {
		url?.showInFinder()
	}
}
