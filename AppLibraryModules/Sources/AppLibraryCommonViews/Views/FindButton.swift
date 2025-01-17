import AppLibraryCommon
import SwiftUI

/// A button that invokes the ``Event/activateSearch`` event.
public struct FindButton<Label>: View where
	Label: View
{
	private let label: Label

	/// - Parameters:
	///   - label:
	public init(
		@ViewBuilder label: () -> Label
	) {
		self.label = label()
	}

	public var body: some View {
		Button(action: buttonAction) {
			label
		}
		.keyboardShortcut(.find)
	}
}

// MARK: - Functions

private extension FindButton {
	func buttonAction() {
		Event.activateSearch.send()
	}
}

// MARK: - Convenience

public extension FindButton where
	Label == SwiftUI.Label<Text, Image>
{
	init() {
		self.init {
			Label(
				String(localized: .common.action.find),
				systemImage: .magnifyingGlass
			)
		}
	}
}
