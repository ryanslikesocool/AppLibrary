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
	@Published var isSearchFocused: Bool // TODO: convert to nil check on searchQuery?
	@Published var focusedIndex: Int?

	var isSearchDisplayed: Bool { state == .complete }

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
		focusedIndex = nil
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
