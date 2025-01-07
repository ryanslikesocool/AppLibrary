import AppKit
import AppLibraryRuntimeModel
import AppLibraryCommon
import AppLibraryStorage
import OSLog
import SwiftUI

extension BrowserModel {
	func onFindShortcut() {
		KeyboardObserver.logger.debug("\(#function): Focusing search.")
		focus = .search
	}

	func onRefreshShortcut() {
		KeyboardObserver.logger.debug("\(#function): Reloading apps.")
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
				return onSubmitSearch()
			case let .application(applicationID):
				return onSubmitApplication(applicationID)
			default:
				KeyboardObserver.logger.debug("\(#function): Search was not focused.")
		}

		return false
	}

	/// - Returns: `true` if the event should be consumed; `false` otherwise.
	@discardableResult
	func onSubmitSearch() -> Bool {
		guard !searchQuery.isEmpty else {
			focus = nil
			KeyboardObserver.logger.debug("\(#function): Search was focused, query was empty.")
			return true
		}

		guard let bestMatch = filteredApps.first else {
			KeyboardObserver.logger.debug("\(#function): Best match for search was not found.")
			return false
		}

		bestMatch.openLatest()
		searchQuery = ""
		KeyboardObserver.logger.debug("\(#function): Opening app for best match.")
		return true
	}

	/// - Returns: `true` if the event should be consumed; `false` otherwise.
	@discardableResult
	func onSubmitApplication(_ applicationID: ApplicationModelIdentifier) -> Bool {
		guard let application = filteredApps.first(where: { application in
			application.bundleIdentifier == applicationID.bundleIdentifier
		}) else {
			return false
		}

		application.openLatest()
		return true
	}

	func onMoveSearch(direction: MoveCommandDirection) {
		let entryElement: KeyPath<[ApplicationModel], ApplicationModel?>? = switch direction.axis {
			case .vertical: direction.getEntryElement()
			default: nil
		}
		guard let entryElement else {
			return
		}

		Logger.module.debug("\(#function): Got entry element from search - \(String(describing: entryElement))")
	}

	func onArrowKey(direction: MoveCommandDirection) {
		guard
			case let .application(applicationID) = focus,
			let currentFocus = filteredApps.firstIndex(where: { application in
				application.bundleIdentifier == applicationID.bundleIdentifier
			})
		else {
			focus = if let entry = filteredApps[keyPath: direction.getEntryElement()] {
				.application(entry)
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
			focus = .application(filteredApps[targetIndex])
		}
	}

	@_disfavoredOverload
	func onAlphanumericKey(_ value: Character?) -> Bool {
		guard let value else {
			return false
		}
		return onAlphanumericKey(value)
	}

	func onAlphanumericKey(_ value: Character) -> Bool {
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
			KeyboardObserver.logger.debug("\(#function): No app results to scroll to.")
			return false
		}

		KeyboardObserver.logger.debug("\(#function): Scrolling to apps starting with \"\(lowercasedString)\".")
		Event.scrollToApp.send(ApplicationModelIdentifier(firstResult))
		return true
	}
}
