import AppLibraryCommon
import SFSymbolToolbox
import SwiftUI

/// A button that invokes the ``Event/refreshApps`` event.
public struct RefreshButton<Label>: View where
	Label: View
{
	private let label: Label

	public init(
		@ViewBuilder label: () -> Label
	) {
		self.label = label()
	}

	public var body: some View {
		Button(action: buttonAction) {
			label
		}
		.keyboardShortcut(.refresh)
	}
}

// MARK: - Functions

private extension RefreshButton {
	func buttonAction() {
		Event.refreshApps.send()
	}
}

// MARK: - Convenience

public extension RefreshButton where
	Label == SwiftUI.Label<Text, Image>
{
	init(
		_ title: LocalizedStringResource,
		systemImage: SystemSymbolName
	) {
		self.init {
			Label(
				title,
				systemImage: systemImage
			)
		}
	}

	init() {
		self.init(
			.common.action.refresh,
			systemImage: .arrow_clockwise
		)
	}
}
