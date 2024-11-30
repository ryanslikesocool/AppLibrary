import AppLibraryCommon
import SwiftUI

public struct RefreshAppsButton<Label>: View where
	Label: View
{
	private let label: () -> Label

	public init(@ViewBuilder label: @escaping () -> Label) {
		self.label = label
	}

	public var body: some View {
		Button(action: buttonAction, label: label)
	}
}

// MARK: - Functions

private extension RefreshAppsButton {
	func buttonAction() {
		Event.refreshApps.send()
	}
}
