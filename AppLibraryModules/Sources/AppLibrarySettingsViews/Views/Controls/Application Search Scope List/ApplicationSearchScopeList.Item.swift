import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryStorage
import SwiftUI

extension ApplicationSearchScopeList {
	struct Item: View {
		private let url: URL
		private let removeSearchScope: () -> Void

		public init(for url: URL, onRemove removeSearchScope: @escaping () -> Void) {
			self.url = url
			self.removeSearchScope = removeSearchScope
		}

		public var body: some View {
			LabeledContent {
				Menu(content: menu) {
					Label("Options", systemImage: Constant.Symbol.ellipsis)
						.frame(height: 16)
						.labelStyle(.iconOnly)
						.contentShape(.rect)
				}
				.fixedSize()
				.menuIndicator(.hidden)
				.buttonStyle(.plain)
			} label: {
				URLLabel(url)
					.monospaced()
					.lineLimit(1)
					.truncationMode(.tail)
					.help(url.abbreviatingWithTildeInPath)
			}
			.contentShape(.rect)
			.contextMenu(menuItems: menu)
		}
	}
}

// MARK: - Supporting Views

private extension ApplicationSearchScopeList.Item {
	@ViewBuilder
	func menu() -> some View {
		Section {
			ShowInFinderButton(url)
		}

		Section {
			RemoveButton(action: removeSearchScope)
		}
	}
}
