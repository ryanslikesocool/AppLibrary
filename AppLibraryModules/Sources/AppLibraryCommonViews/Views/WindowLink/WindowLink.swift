import AppLibraryCommon
import AppLibraryResources
import SFSymbolToolbox
import SwiftUI

public struct WindowLink<Label>: View where
	Label: View
{
	@Environment(\.openWindow) private var openWindow

	/// A view that describes the destination of the link.
	private let label: Label

	/// The identifier of the window to open.
	private let id: WindowIdentifier

	/// - Parameters:
	///   - id: The identifier of the window to open.
	///   - label: A view that describes the destination of the link.
	public init(
		id: WindowIdentifier,
		@ViewBuilder label: () -> Label
	) {
		self.id = id
		self.label = label()
	}

	public var body: some View {
		Button(action: buttonAction) {
			label
		}
	}
}

// MARK: - Functions

private extension WindowLink {
	func buttonAction() {
		openWindow(id: id)
	}
}
