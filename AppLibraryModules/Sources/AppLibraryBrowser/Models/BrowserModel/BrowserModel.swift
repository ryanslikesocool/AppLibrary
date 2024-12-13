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

	var isSearchDisplayed: Bool {
		if case .complete = state {
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

	@MainActor
	static func hiddenAppsFilterBrowser(application: Application) -> Bool {
		if let hideFlags = AppsSettings.shared.applicationHideFlags[application.id] {
			!hideFlags.contains(.hiddenInBrowser)
		} else {
			true
		}
	}

	@MainActor
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

extension BrowserModel {
	func filteredAppsChanged(_ newValue: borrowing [Application]) {
		guard searchQuery.isEmpty else {
			return
		}

		state = if newValue.isEmpty {
			.failed(reason: .allAppsHidden)
		} else {
			.complete
		}
	}
}
