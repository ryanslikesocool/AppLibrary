import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryStorage
import OSLog
import SwiftUI

struct ApplicationSearchScopeList: View {
	@Storage(locations: \.self) private var locations
	@Storage(locations: \.searchScopes) private var searchScopes

	public init() { }

	public var body: some View {
		Section {
			if searchScopes.isEmpty {
				emptyListLabel
			} else {
				listContent
			}
		} header: {
			Text("LIST.TITLE", table: .applicationSearchScopeList)
			Text("LIST.DESCRIPTION", table: .applicationSearchScopeList)
		} footer: {
			AddMenu()
		}

		.onChange(of: searchScopes, onSearchScopesChanged)
	}
}

// MARK: - Supporting Views

private extension ApplicationSearchScopeList {
	var emptyListLabel: some View {
		Text("LIST.EMPTY_LABEL", table: .applicationSearchScopeList)
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

private extension ApplicationSearchScopeList {
	func onSearchScopesChanged() {
		Event.refreshApps.send()
	}

	func removeSearchScope(at url: URL) {
		locations.removeSearchScope(at: url)
	}
}
