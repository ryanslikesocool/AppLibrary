import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryStorage
import SwiftUI

extension ApplicationSearchScopesList {
	struct Item: View {
		@Environment(\.delete) private var delete

		private let url: URL

		public init(for url: URL) {
			self.url = url
		}

		public var body: some View {
			URLLabel(url)
				.monospaced()
				.lineLimit(1)
				.truncationMode(.tail)
				.help(url.abbreviatingWithTildeInPath)

				.swipeActions(
					edge: .trailing,
					allowsFullSwipe: false,
					content: makeSwipeActions
				)
		}
	}
}

// MARK: - Supporting Views

private extension ApplicationSearchScopesList.Item {
	func makeSwipeActions() -> some View {
		RemoveButton {
			delete?()
		}
	}
}
