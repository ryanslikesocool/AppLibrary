import Cocoa

final class AppMenu: NSMenu {
	private lazy var applicationName = ProcessInfo.processInfo.processName

	override init(title: String) {
		super.init(title: title)

		let mainMenu = NSMenuItem()
		mainMenu.submenu = NSMenu(title: "MainMenu")
		mainMenu.submenu?.items = [
			NSMenuItem(title: "About \(applicationName)", action: #selector(NSApplication.orderFrontStandardAboutPanel(_:)), keyEquivalent: ""),
			NSMenuItem.separator(),
			NSMenuItem(title: "Settings...", action: #selector(NSApplication.orderFrontSettingsPanel(_:)), keyEquivalent: ","),
			NSMenuItem.separator(),
			NSMenuItem(title: "Hide \(applicationName)", action: #selector(NSApplication.hide(_:)), keyEquivalent: "h"),
			NSMenuItem.separator(),
			NSMenuItem(title: "Quit \(applicationName)", action: #selector(NSApplication.shared.terminate(_:)), keyEquivalent: "q"),
		]

		let editMenu = NSMenuItem()
		editMenu.submenu = NSMenu(title: "Edit")
		editMenu.submenu?.items = [
			NSMenuItem(title: "Undo", action: #selector(UndoManager.undo), keyEquivalent: "z"),
			NSMenuItem(title: "Redo", action: #selector(UndoManager.redo), keyEquivalent: "Z"),
			NSMenuItem.separator(),
			NSMenuItem(title: "Cut", action: #selector(NSText.cut(_:)), keyEquivalent: "x"),
			NSMenuItem(title: "Copy", action: #selector(NSText.copy(_:)), keyEquivalent: "c"),
			NSMenuItem(title: "Paste", action: #selector(NSText.paste(_:)), keyEquivalent: "v"),
			NSMenuItem.separator(),
			NSMenuItem(title: "Select All", action: #selector(NSText.selectAll(_:)), keyEquivalent: "a"),
		]

		let helpMenu = NSMenuItem()
		let helpMenuSearch = NSMenuItem()
		helpMenuSearch.view = NSTextField()
		helpMenu.submenu = NSMenu(title: "Help")
		helpMenu.submenu?.items = [
			helpMenuSearch,
		]

		items = [mainMenu, editMenu, helpMenu]
	}

	@available(*, unavailable)
	required init(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
