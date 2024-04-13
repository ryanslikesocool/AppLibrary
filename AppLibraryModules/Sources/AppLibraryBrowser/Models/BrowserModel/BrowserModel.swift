import AppLibraryStorage
import SwiftUI

final class BrowserModel: ObservableObject {
	static let shared: BrowserModel = BrowserModel()

	@Published var apps: [Application]
	@Published var queryState: BrowserQueryState?
	@Published var searchQuery: String
	@Published var isSearchFocused: Bool

	var filteredApps: [Application] {
		var filtered = apps.filter(hiddenAppsFilter)
		if !searchQuery.isEmpty {
			filtered = filtered.filter(searchFilter)
		}
		return filtered
	}

	var activeMetadataQuery: NSMetadataQuery?

	private(set) lazy var keyboardObserver: KeyboardObserver = KeyboardObserver(model: self)

	private init() {
		apps = []
		searchQuery = ""
		isSearchFocused = false
		reloadApps()
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
		isSearchFocused = true
	}

	func onRefreshShortcut() {
		reloadApps()
	}

	func onEscapeKey() {
		if isSearchFocused {
			searchQuery = ""
			isSearchFocused = false
		} else {
			NSApplication.shared.hide(nil)
		}
	}

	func onReturnKey() -> Bool {
		if isSearchFocused {
			isSearchFocused = false
			return true
		} else {
			return false
		}
	}

	func onAnyKey(_ value: String?) -> Bool {
		guard
			!isSearchFocused,
			let lowercasedString = value?.lowercased(),
			let firstResult = apps.first(where: { $0.displayName.lowercased().starts(with: lowercasedString) })
		else {
			return false
		}

		NotificationCenter.default.post(name: Event.scrollToApp, object: nil, userInfo: [0: firstResult.id])
		return true
	}
}
