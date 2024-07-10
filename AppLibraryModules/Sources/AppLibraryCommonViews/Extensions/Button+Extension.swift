import AppLibraryCommon
import SwiftUI

public extension Button where Label == SwiftUI.Label<Text, Image> {
	static func showInFinder(_ url: URL) -> Self {
		Button(action: url.showInFinder, label: Label.showInFinder)
	}

	@ViewBuilder static func showInFinder(_ url: URL?) -> some View {
		if let url {
			Button.showInFinder(url)
		} else {
			Button(action: { }, label: Label.showInFinder)
				.disabled(true)
		}
	}
}
