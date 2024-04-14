import AppLibraryCommon
import AppLibraryStorage
import Combine
import OSLog
import SwiftUI

final class BrowserModel: ObservableObject {
	static let shared: BrowserModel = BrowserModel()

	@Published var state: BrowserState?
	@Published var apps: [Application]
	@Published var searchQuery: String
	@Published var isSearchFocused: Bool

	var isSearchDisplayed: Bool {
		!AppSettings.shared.discovery.searchScopes.isEmpty && !filteredApps.isEmpty
	}

	var filteredApps: [Application] {
		var filtered = apps.filter(hiddenAppsFilter)
		if !searchQuery.isEmpty {
			filtered = filtered.filter(searchFilter)
		}
		return filtered
	}

	var activeMetadataQuery: NSMetadataQuery?

	private(set) lazy var keyboardObserver: KeyboardObserver = KeyboardObserver(model: self)

	private lazy var refreshAppsSubscription: AnyCancellable? = Event.refreshApps
		.sink(receiveValue: refreshApps)

	private init() {
		apps = []
		searchQuery = ""
		isSearchFocused = false
		refreshApps()

		_ = refreshAppsSubscription
	}
}

private extension BrowserModel {
	func searchFilter(application: Application) -> Bool {
		application.displayName.localizedStandardContains(searchQuery)
	}

	func hiddenAppsFilter(application: Application) -> Bool {
		!AppSettings.shared.apps.hiddenApps.contains(application.id)
	}
}

extension BrowserModel {
	func onSearchShortcut() {
		Logger.keyboardEvents.debug("Search Shortcut: Focusing search.")
		isSearchFocused = true
	}

	func onRefreshShortcut() {
		Logger.keyboardEvents.debug("Refresh Shortcut: Reloading apps.")
		refreshApps()
	}

	func onEscapeKey() {
		if isSearchFocused {
			searchQuery = ""
			isSearchFocused = false
			Logger.keyboardEvents.debug("Escape Key: Unfocusing search.")
		} else {
			NSApplication.shared.hide(nil)
			Logger.keyboardEvents.debug("Escape Key: Hiding app.")
		}
	}

	func onReturnKey() -> Bool {
		if isSearchFocused {
			if !searchQuery.isEmpty {
				if let bestMatch = filteredApps.first {
					bestMatch.open()
					searchQuery = ""
					Logger.keyboardEvents.debug("Return Key: Opening app for best match.")
					return true
				} else {
					Logger.keyboardEvents.debug("Return Key: Best match for search was not found.")
					return false
				}
			} else {
				isSearchFocused = false
				Logger.keyboardEvents.debug("Return Key: Search was focused, query was empty.")
				return true
			}
		} else {
			Logger.keyboardEvents.debug("Return Key: Search was not focused.")
			return false
		}
	}

	func onAnyKey(_ value: String?) -> Bool {
		guard !isSearchFocused else {
			return false
		}

		guard
			let lowercasedString = value?.lowercased(),
			let firstResult = filteredApps.first(where: { $0.displayName.lowercased().starts(with: lowercasedString) })
		else {
			Logger.keyboardEvents.debug("Any Key: No app results to scroll to.")
			return false
		}

		Logger.keyboardEvents.debug("Any Key: Scrolling to apps starting with \"\(lowercasedString)\".")
		Event.scrollToApp.send(firstResult.id)
		return true
	}
}
