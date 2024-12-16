import AppLibraryCommon
import AppLibraryStorage
import Combine
import OSLog
import SwiftUI

final class BrowserModel: ObservableObject {
	private let applicationCache: ApplicationCache
//	private var applicationCache: ApplicationCache { .shared }

	@Published private(set) var state: BrowserState
	@Published var searchQuery: String
	@Published var focus: FocusElement?

	@MainActor
	var apps: [Application] { applicationCache.applications }

	@MainActor
	var isSearchDisplayed: Bool {
		if case .idle = applicationCache.state {
			true
		} else {
			false
		}
	}

	@MainActor
	var filteredApps: [Application] {
		var filtered: [Application]
		if searchQuery.isEmpty {
			filtered = apps.filter(Self.hiddenAppsFilterBrowser)
		} else {
			filtered = apps.filter(Self.hiddenAppsFilterSearch)
			filtered = filtered.filter(searchFilter)
		}
		return filtered
	}

	private(set) lazy var keyboardObserver: KeyboardObserver = KeyboardObserver(model: self)

	@MainActor
	private lazy var refreshAppsSubscriber: AnyCancellable? = Event.refreshApps
		.sink(receiveValue: refreshApps)

	@MainActor
	private lazy var activateSearchSubscriber: AnyCancellable? = Event.activateSearch
		.sink(receiveValue: activateSearch)

	@MainActor
	init() {
		state = .idle
		searchQuery = ""
		focus = nil

		applicationCache = ApplicationCache()
		applicationCache.delegate = self

		refreshApps()

		_ = refreshAppsSubscriber
		_ = activateSearchSubscriber
	}
}

// MARK: - ApplicationCacheDelegate

extension BrowserModel: ApplicationCacheDelegate {
	func applicationCache(didFinishQuery results: borrowing [Application]) {
		state = .idle
	}
}

// MARK: -

extension BrowserModel {
	private func searchFilter(application: Application) -> Bool {
		application.displayName.localizedStandardContains(searchQuery)
	}

	@MainActor
	private static func hiddenAppsFilterBrowser(application: Application) -> Bool {
		if let hideFlags = AppsSettings.shared.applicationHideFlags[application.id] {
			!hideFlags.contains(.hiddenInBrowser)
		} else {
			true
		}
	}

	@MainActor
	private static func hiddenAppsFilterSearch(application: Application) -> Bool {
		if let hideFlags = AppsSettings.shared.applicationHideFlags[application.id] {
			!hideFlags.contains(.hiddenInSearch)
		} else {
			true
		}
	}

	private func activateSearch() {
		focus = .search
	}

	func filteredAppsChanged(_ newValue: borrowing [Application]) {
		guard searchQuery.isEmpty else {
			return
		}

		state = if newValue.isEmpty {
			.error(.allApplicationsHidden)
		} else {
			.idle
		}
	}

	@MainActor
	func refreshApps() {
		do {
			let searchScopes = try getSearchScopes()

			state = .loading
			applicationCache.reload(searchScopes: searchScopes)
		} catch {
			state = .error(error)
		}

		func getSearchScopes() throws(BrowserError) -> [URL] {
			let searchScopes = LocationSettings.shared.searchScopes
			guard !searchScopes.isEmpty else {
				throw .noSearchScopes
			}
			return Array(searchScopes)
		}
	}
}