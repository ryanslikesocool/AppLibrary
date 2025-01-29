import AppLibraryCommon
import AppLibraryRuntimeModel
import AppLibraryStorage
import Combine
import OSLog
import SwiftUI

@MainActor
final class BrowserModel: ObservableObject {
	// TODO: Convert to `willSet { objectWillChange.send() }`?
	@Published private(set) var state: BrowserState

	@Published var search: SearchModel

	var isSearchDisplayed: Bool {
		if case .idle = ApplicationCache.shared.state {
			true
		} else {
			false
		}
	}

	var filteredApps: [ApplicationModel] {
		// NOTE: Despite this being a computed property, SwiftUI *seems* to be smart enough
		// to compute this a reasonable number of times, so there's not a huge need for optimization.
		// That said, it may be something to revisit in the future.

//		ApplicationCache.shared.applications.values
//			.filter(searchQuery: searchQuery)

		ApplicationCache.shared.applications.values.filter(using: search)
	}

	// NOTE: Annoyingly, this seems to be required to force the view to update.
	// Something to revisit in the future.
	private lazy var applicationFilterChangeSubscriber: AnyCancellable = Publishers.CombineLatest(
		ApplicationCache.shared.$applications,
		AppsSettings.shared.$applicationVisibilityFlags
//		$searchQuery // Already `@Published` locally
	)
	.sink { _, _ in
		self.objectWillChange.send()
	}

	init() {
		state = .idle
		search = SearchModel()

		refreshApps()

		_ = applicationFilterChangeSubscriber
	}
}

// MARK: - Constants

extension BrowserModel {
	nonisolated static let logger = Logger(category: BrowserModel.self)
}

// MARK: -

extension BrowserModel {
	func refreshApps() {
		do {
			let searchScopes = try getSearchScopes()

			state = .loading

			// TODO: Does this task ever need to be cancelled?
			// We should probably only ever need the task from `ApplicationCacheState.loading(task:)`
			// That said, there's probably a better way to handle this, rather than starting 2 tasks.
			Task {
				await ApplicationCache.shared.reload(searchScopes: searchScopes)

				self.state = .idle
			}
		} catch {
			state = .error(error)
		}

		func getSearchScopes() throws(BrowserError) -> [URL] {
			let searchScopes = AppsSettings.shared.searchScopes
			guard !searchScopes.isEmpty else {
				throw .noSearchScopes
			}
			return Array(searchScopes)
		}
	}
}
