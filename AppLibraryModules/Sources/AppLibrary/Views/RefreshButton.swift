import AppLibraryCommon
import SwiftUI

struct RefreshButton: View {
	public init() { }

	public var body: some View {
		Button(
			.mainMenu.item.refresh,
			action: buttonAction
		)
		.keyboardShortcut(.refresh)
	}
}

// MARK: - Functions

private extension RefreshButton {
	func buttonAction() {
		if FeatureFlag.MainMenu.logAction {
			MainMenu.logger.debug("Invoking \(Self.self) action.")
		}

		Event.refreshApps.send()
	}
}
