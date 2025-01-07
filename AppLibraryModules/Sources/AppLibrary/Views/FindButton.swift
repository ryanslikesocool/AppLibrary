import AppLibraryCommon
import SwiftUI

struct FindButton: View {
	public init() { }

	public var body: some View {
		Button(
			.mainMenu.item.find,
			action: buttonAction
		)
		.keyboardShortcut(.find)
	}
}

// MARK: - Functions

private extension FindButton {
	func buttonAction() {
		if FeatureFlag.MainMenu.logAction {
			MainMenu.logger.debug("Invoking \(Self.self) action.")
		}

		Event.activateSearch.send()
	}
}
