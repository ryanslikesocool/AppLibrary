import AppKit
import AppLibraryCommon
import AppLibraryStorage
import OSLog

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
		searchQuery = ""
		isSearchFocused = false
		focusedIndex = nil
		NSApplication.shared.hide(nil)
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
		} else if let focusedIndex {
//			filteredApps[focusedIndex].open()
			return true
		} else {
			Logger.keyboardEvents.debug("Return Key: Search was not focused.")
			return false
		}
	}

	func onArrowKey(_ direction: NavigationDirection) {
		guard let currentFocus = focusedIndex else {
			focusedIndex = filteredApps.indices[keyPath: direction.entryIndex]
			return
		}

		let offset = direction.offset(for: AppSettings.shared.layout.layout)
		let targetIndex = currentFocus + offset

		if targetIndex < 0 {
			isSearchFocused = true
		} else if targetIndex >= filteredApps.count {
			focusedIndex = nil
		} else {
			focusedIndex = targetIndex
		}
	}

	func onAlphanumericKey(_ value: String?) -> Bool {
		guard
			!isSearchFocused,
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
