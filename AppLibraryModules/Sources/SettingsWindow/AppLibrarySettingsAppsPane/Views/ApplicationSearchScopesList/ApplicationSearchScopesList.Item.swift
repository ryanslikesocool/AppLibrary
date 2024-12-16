import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryStorage
import SwiftUI

extension ApplicationSearchScopesList {
	struct Item: View {
		private let url: URL
		private let removeSearchScope: () -> Void

		public init(for url: URL, onRemove removeSearchScope: @escaping () -> Void) {
			self.url = url
			self.removeSearchScope = removeSearchScope
		}

		public var body: some View {
			LabeledContent {
				Menu(content: makeMenuContent) {
					Label {
						Text(.applicationSearchScopesList.item.optionsLabel, table: .applicationSearchScopesList)
					} icon: {
						Image(systemName: Constant.Symbol.ellipsis)
					}
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
			.contextMenu(menuItems: makeMenuContent)
		}
	}
}

// MARK: - Supporting Views

private extension ApplicationSearchScopesList.Item {
	@ViewBuilder
	func makeMenuContent() -> some View {
		Section {
			ShowInFinderButton(url)
		}

		Section {
			RemoveButton(action: removeSearchScope)
		}
	}
}
