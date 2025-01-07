import AppLibraryCommon
import AppLibraryRuntimeModel
import AppLibraryStorage
import Combine
import OSLog
import SwiftUI

@MainActor
final class BrowserModel: ObservableObject {
	private var applicationCache: ApplicationCache { .shared }

	@Published private(set) var state: BrowserState
	@Published var searchQuery: String
	@Published var focus: BrowserFocusElement?

	var isSearchDisplayed: Bool {
		if case .idle = applicationCache.state {
			true
		} else {
			false
		}
	}

	var filteredApps: [ApplicationModel] {
		ApplicationFilter.filter(applicationCache.applications.values, searchQuery: searchQuery)
	}

	let keyboardObserver: KeyboardObserver

	private lazy var refreshAppsSubscriber: AnyCancellable? = Event.refreshApps
		.sink { self.refreshApps() }

	private lazy var activateSearchSubscriber: AnyCancellable? = Event.activateSearch
		.sink { self.activateSearch() }

	init() {
		state = .idle
		searchQuery = ""
		focus = nil
		keyboardObserver = KeyboardObserver()

		refreshApps()

		if FeatureFlag.Input.implementation == .keyboardObserver {
			keyboardObserver.delegate = self
		}

		_ = refreshAppsSubscriber
		_ = activateSearchSubscriber
	}
}

// MARK: -

extension BrowserModel {
	private func activateSearch() {
		focus = .search
	}

	func filteredAppsChanged(_ newValue: borrowing [ApplicationModel]) {
		guard searchQuery.isEmpty else {
			return
		}

		state = if newValue.isEmpty {
			.error(.allApplicationsHidden)
		} else {
			.idle
		}
	}

	func refreshApps() {
		do {
			let searchScopes = try getSearchScopes()

			state = .loading

			// TODO: Does this task ever need to be cancelled?
			// We should probably only ever need the task from `ApplicationCacheState.loading(task:)`
			// That said, there's probably a better way to handle this, rather than starting 2 tasks.
			Task {
				await applicationCache.reload(searchScopes: searchScopes)

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
