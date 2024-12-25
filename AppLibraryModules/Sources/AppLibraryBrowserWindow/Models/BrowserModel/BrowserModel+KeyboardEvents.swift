import AppKit
import AppLibraryCommon
import AppLibraryStorage
import OSLog

extension BrowserModel {
	func onSearchShortcut() {
		Logger.keyboardEvents.debug("Search Shortcut: Focusing search.")
		focus = .search
	}

	@MainActor
	func onRefreshShortcut() {
		Logger.keyboardEvents.debug("Refresh Shortcut: Reloading apps.")
		refreshApps()
	}

	func onEscapeKey() {
		searchQuery = ""
		focus = nil
		NSApplication.shared.hide(nil)
	}

	@MainActor
	func onReturnKey() -> Bool {
		switch focus {
			case .search:
				if !searchQuery.isEmpty {
					if let bestMatch = filteredApps.first {
						bestMatch.openLatest()
						searchQuery = ""
						Logger.keyboardEvents.debug("Return Key: Opening app for best match.")
						return true
					} else {
						Logger.keyboardEvents.debug("Return Key: Best match for search was not found.")
						return false
					}
				} else {
					focus = nil
					Logger.keyboardEvents.debug("Return Key: Search was focused, query was empty.")
					return true
				}
			case let .app(applicationID):
				if let application = filteredApps.first(where: { application in
					application.bundleIdentifier == applicationID.bundleIdentifier
				}) {
					application.openLatest()
					return true
				}
			default:
				Logger.keyboardEvents.debug("Return Key: Search was not focused.")
		}

		return false
	}

	@MainActor
	func onArrowKey(_ direction: NavigationDirection) {
		guard
			case let .app(applicationID) = focus,
			let currentFocus = filteredApps.firstIndex(where: { application in
				application.bundleIdentifier == applicationID.bundleIdentifier
			})
		else {
			focus = if let entry = filteredApps[keyPath: direction.getEntry()] {
				.app(ApplicationModelIdentifier(entry))
			} else {
				nil
			}
			return
		}

		let offset = direction.offset(for: LayoutSettings.shared.layout)
		let targetIndex = currentFocus + offset

		if targetIndex < 0 {
			focus = .search
		} else if targetIndex >= filteredApps.count {
			focus = nil
		} else {
			focus = .app(ApplicationModelIdentifier(filteredApps[targetIndex]))
		}
	}

	@MainActor
	func onAlphanumericKey(_ value: String?) -> Bool {
		guard
			focus != .search,
			let lowercasedString = value?.lowercased(),
			lowercasedString.isAlphanumeric
		else {
			return false
		}

		guard
			let firstResult = filteredApps.first(where: { application in
				application.displayName.lowercased().starts(with: lowercasedString)
			})
		else {
			Logger.keyboardEvents.debug("Any Key: No app results to scroll to.")
			return false
		}

		Logger.keyboardEvents.debug("Any Key: Scrolling to apps starting with \"\(lowercasedString)\".")
		Event.scrollToApp.send(ApplicationModelIdentifier(firstResult))
		return true
	}
}
