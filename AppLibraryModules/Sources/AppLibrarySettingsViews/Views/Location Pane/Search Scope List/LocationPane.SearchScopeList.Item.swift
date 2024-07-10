import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryStorage
import SwiftUI

extension LocationPane.SearchScopeList {
	struct Item: View {
		@ObservedObject var model: LocationSettings
		private let url: URL

		init(model: LocationSettings, for url: URL) {
			self.model = model
			self.url = url
		}

		var body: some View {
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
				Text(url: url)
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

private extension LocationPane.SearchScopeList.Item {
	@ViewBuilder func menu() -> some View {
		Section {
			Button.showInFinder(url)
		}

		Section {
			Button(
				action: { model.removeSearchScope(at: url) },
				label: Label.remove
			)
		}
	}
}
