import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryStorage
import OSLog
import SwiftUI

struct ApplicationSearchScopesList: View {
	@Storage(apps: \.searchScopes) private var searchScopes

	public init() { }

	public var body: some View {
		Group {
			if searchScopes.isEmpty {
				emptyListLabel
			} else {
				listContent
			}
		}
		.onChange(of: searchScopes, onSearchScopesChanged)
	}
}

// MARK: - Supporting Views

private extension ApplicationSearchScopesList {
	var emptyListLabel: some View {
		Text(.applicationSearchScopesList.list.emptyLabel)
			.foregroundStyle(.secondary)
	}

	var listContent: some View {
		let searchScopes = searchScopes
			.sorted(using: URL.PathComparator())

		return ForEach(searchScopes, id: \.self) { url in
			Item(
				for: url,
				onRemove: { removeSearchScope(at: url) }
			)
		}
	}
}

// MARK: - Functions

private extension ApplicationSearchScopesList {
	func onSearchScopesChanged() {
		Event.refreshApps.send()
	}

	func removeSearchScope(at url: URL) {
		searchScopes.remove(url)
	}
}
