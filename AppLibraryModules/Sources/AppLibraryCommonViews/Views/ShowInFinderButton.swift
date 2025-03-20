import AppLibraryCommon
import AppLibraryResources
import SwiftUI

public struct ShowInFinderButton<Label>: View where
	Label: View
{
	private let urls: [URL]
	private let label: Label

	public init(
		_ urls: some Sequence<URL>,
		@ViewBuilder label: () -> Label
	) {
		self.urls = urls.sorted(using: .path())
		self.label = label()
	}

	public var body: some View {
		Button(action: buttonAction) {
			label
		}
		.disabled(urls.isEmpty)
	}
}

// MARK: - Constants

private extension ShowInFinderButton where
	Label == SwiftUI.Label<Text, Image>
{
	nonisolated static func makeDefaultLabel() -> Label {
		Label(
			String(localized: .common.action.showInFinder),
			image: .finder
		)
	}
}

// MARK: - Functions

private extension ShowInFinderButton {
	func buttonAction() {
		urls.showInFinder()
	}
}

// MARK: - Convenience

public extension ShowInFinderButton {
	init(
		_ url: URL?,
		@ViewBuilder label: () -> Label
	) {
		let urls: [URL] = if let url {
			[url]
		} else {
			[]
		}
		self.init(urls, label: label)
	}
}

public extension ShowInFinderButton where
	Label == SwiftUI.Label<Text, Image>
{
	init(_ urls: some Sequence<URL>) {
		self.init(urls, label: Self.makeDefaultLabel)
	}

	init(_ url: URL?) {
		self.init(url, label: Self.makeDefaultLabel)
	}
}
