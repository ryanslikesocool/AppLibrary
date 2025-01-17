import AppLibraryCommon
import AppLibraryResources
import SwiftUI

public struct ShowInFinderButton<Label>: View where
	Label: View
{
	private let url: URL?
	private let label: Label

	/// - Parameters:
	///   - url:
	///   - label:
	public init(
		_ url: URL?,
		@ViewBuilder label: () -> Label
	) {
		self.url = url
		self.label = label()
	}

	public var body: some View {
		Button(action: buttonAction) {
			label
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

// MARK: - Convenience

public extension ShowInFinderButton where
	Label == SwiftUI.Label<Text, Image>
{
	/// - Parameters:
	///   - url:
	init(_ url: URL?) {
		self.init(url) {
			Label(
				String(localized: .common.action.showInFinder),
				image: .finder
			)
		}
	}
}
