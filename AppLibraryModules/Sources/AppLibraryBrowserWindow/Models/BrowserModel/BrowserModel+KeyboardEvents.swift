import AppKit
import AppLibraryCommon
import AppLibraryStorage
import OSLog
import SwiftUI

extension BrowserModel {
	func onFindShortcut() {
		KeyboardObserver.logger.debug("Find Shortcut: Focusing search.")
		focus = .search
	}

	func onRefreshShortcut() {
		KeyboardObserver.logger.debug("Refresh Shortcut: Reloading apps.")
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
						bestMatch.openLatest()
						searchQuery = ""
						KeyboardObserver.logger.debug("Return Key: Opening app for best match.")
						return true
					} else {
						KeyboardObserver.logger.debug("Return Key: Best match for search was not found.")
						return false
					}
				} else {
					focus = nil
					KeyboardObserver.logger.debug("Return Key: Search was focused, query was empty.")
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
				KeyboardObserver.logger.debug("Return Key: Search was not focused.")
		}

		return false
	}

	func onArrowKey(_ direction: MoveCommandDirection) {
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

	func onAlphanumericKey(_ value: Character?) -> Bool {
		guard let value else {
			return false
		}
		return onAlphanumericKey(String(value))
	}

	@_disfavoredOverload
	func onAlphanumericKey(_ value: String?) -> Bool {
		guard let value else {
			return false
		}
		return onAlphanumericKey(value)
	}

	func onAlphanumericKey(_ value: String) -> Bool {
		guard focus != .search else {
			return false
		}

		let lowercasedString = value.lowercased()
		guard lowercasedString.isAlphanumeric else {
			return false
		}

		guard
			let firstResult = filteredApps.first(where: { application in
				application.displayName.lowercased().starts(with: lowercasedString)
			})
		else {
			KeyboardObserver.logger.debug("Any Key: No app results to scroll to.")
			return false
		}

		KeyboardObserver.logger.debug("Any Key: Scrolling to apps starting with \"\(lowercasedString)\".")
		Event.scrollToApp.send(ApplicationModelIdentifier(firstResult))
		return true
	}
}
