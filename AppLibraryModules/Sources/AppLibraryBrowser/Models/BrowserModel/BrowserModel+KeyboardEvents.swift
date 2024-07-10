import AppKit
import AppLibraryCommon
import AppLibraryStorage
import OSLog

extension BrowserModel {
	func onSearchShortcut() {
		Logger.keyboardEvents.debug("Search Shortcut: Focusing search.")
		focus = .search
	}

	func onRefreshShortcut() {
		Logger.keyboardEvents.debug("Refresh Shortcut: Reloading apps.")
		refreshApps()
	}

	func onEscapeKey() {
		searchQuery = ""
		focus = nil
		NSApplication.shared.hide(nil)
	}

	func onReturnKey() -> Bool {
		switch focus {
			case .search:
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
					focus = nil
					Logger.keyboardEvents.debug("Return Key: Search was focused, query was empty.")
					return true
				}
			case let .app(app):
				if let app = filteredApps.first(where: { $0.id == app }) {
					app.open()
					return true
				}
			default:
				Logger.keyboardEvents.debug("Return Key: Search was not focused.")
		}

		return false
	}

	func onArrowKey(_ direction: NavigationDirection) {
		guard
			case let .app(appID) = focus,
			let currentFocus = filteredApps.firstIndex(where: { $0.id == appID })
		else {
			focus = if let entry: Application = filteredApps[keyPath: direction.getEntry()] {
				.app(entry.id)
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
			focus = .app(filteredApps[targetIndex].id)
		}
	}

	func onAlphanumericKey(_ value: String?) -> Bool {
		guard
			focus != .search,
			let lowercasedString = value?.lowercased(),
			lowercasedString.isAlphanumeric
		else {
			return false
		}

		guard
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
