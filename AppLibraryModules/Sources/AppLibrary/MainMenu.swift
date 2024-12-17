import AppKit
import AppLibraryCommon
import AppLibraryLocalization
import OSLog

@MainActor
final class MainMenu {
	init() {
		guard let mainMenu = NSApp.mainMenu else {
			preconditionFailure("Failed to access the main menu.")
		}

		if #available(macOS 15.2, *) {
			mainMenu.automaticallyInsertsWritingToolsItems = false
		}

		initializeEditSubmenu(in: mainMenu)
		initializeViewSubmenu(in: mainMenu)
	}
}

// MARK: - Constants

private extension MainMenu {
	static let logger: Logger = Logger(category: MainMenu.self)
}

// MARK: -

private extension MainMenu {
	// TODO: Find a better way to access submenus.
	// There's no reason we should have to search by (localized) name.

	func initializeEditSubmenu(in menu: NSMenu) {
		guard let submenu = menu.item(withTitle: .mainMenu.submenu.edit)?.submenu else {
			return
		}
		Self.logger.debug("Create \"Edit\" submenu items.")

		let item = submenu.addItem(
			withTitle: String(localized: .mainMenu.item.search),
			action: #selector(activateSearchAction),
			keyEquivalent: "f"
		)
		item.target = self
	}

	func initializeViewSubmenu(in menu: NSMenu) {
		guard let submenu = menu.item(withTitle: .mainMenu.submenu.view)?.submenu else {
			return
		}
		Self.logger.debug("Create \"View\" submenu items.")

		let item = submenu.addItem(
			withTitle: String(localized: .mainMenu.item.refresh),
			action: #selector(refreshLibraryAction),
			keyEquivalent: "r"
		)
		item.target = self
	}
}

// MARK: - Actions

private extension MainMenu {
	@objc
	func activateSearchAction() {
		Event.activateSearch.send()
	}

	@objc
	func refreshLibraryAction() {
		Event.refreshApps.send()
	}
}
