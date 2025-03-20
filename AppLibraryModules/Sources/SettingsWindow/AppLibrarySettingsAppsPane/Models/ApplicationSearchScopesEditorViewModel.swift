import AppLibraryStorage
import Foundation

@Observable
final class ApplicationSearchScopesEditorViewModel {
	public var state: State
	public var selections: Set<URL>

	public init() {
		state = .idle
		selections = []
	}
}

// MARK: -

@MainActor
extension ApplicationSearchScopesEditorViewModel {
	func addSearchScope(_ url: URL) {
		@Storage(apps: \.searchScopes) var searchScopes
		searchScopes.insert(url)
	}

	func removeSearchScope(_ url: URL) {
		selections.remove(url)

		@Storage(apps: \.searchScopes) var searchScopes
		searchScopes.remove(url)
	}

	func removeSearchScopes(_ urls: some Sequence<URL>) {
		for url in urls {
			removeSearchScope(url)
		}
	}

	var defaultDeleteAction: (() -> Void)? {
		if selections.isEmpty {
			nil
		} else {
			{ [weak self] in
				guard let self else {
					return
				}
				removeSearchScopes(selections)
			}
		}
	}
}