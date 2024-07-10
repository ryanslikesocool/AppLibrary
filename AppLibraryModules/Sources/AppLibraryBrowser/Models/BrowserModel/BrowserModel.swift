import AppLibraryCommon
import AppLibraryStorage
import Combine
import OSLog
import SwiftUI

final class BrowserModel: ObservableObject {
	@Published var state: BrowserState?
	@Published var apps: [Application]
	@Published var searchQuery: String
	@Published var focus: FocusElement?

	var isSearchDisplayed: Bool { state == .complete }

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

	var activeMetadataQuery: NSMetadataQuery?

	private(set) lazy var keyboardObserver: KeyboardObserver = KeyboardObserver(model: self)

	private lazy var refreshAppsSubscriber: AnyCancellable? = Event.refreshApps
		.sink(receiveValue: refreshApps)
	private lazy var activateSearchSubscriber: AnyCancellable? = Event.activateSearch
		.sink(receiveValue: activateSearch)

	init() {
		apps = []
		searchQuery = ""
		focus = nil
		refreshApps()

		_ = refreshAppsSubscriber
		_ = activateSearchSubscriber
	}
}

private extension BrowserModel {
	func searchFilter(application: Application) -> Bool {
		application.displayName.localizedStandardContains(searchQuery)
	}

	static func hiddenAppsFilterBrowser(application: Application) -> Bool {
		if let hideFlags = AppsSettings.shared.applicationHideFlags[application.id] {
			!hideFlags.contains(.hiddenInBrowser)
		} else {
			true
		}
	}

	static func hiddenAppsFilterSearch(application: Application) -> Bool {
		if let hideFlags = AppsSettings.shared.applicationHideFlags[application.id] {
			!hideFlags.contains(.hiddenInSearch)
		} else {
			true
		}
	}

	func activateSearch() {
		focus = .search
	}
}
