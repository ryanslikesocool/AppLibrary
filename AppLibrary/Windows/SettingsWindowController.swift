import Cocoa
import SwiftUI

final class SettingsWindowController: NSWindowController, ObservableObject {
	@Published var activeTab: SettingsTab

	init() {
		activeTab = .display

		let window = NSWindow(
			contentRect: NSRect(x: 0, y: 0, width: 400, height: 500),
			styleMask: [.miniaturizable, .closable, .titled],
			backing: .buffered,
			defer: false
		)

		super.init(window: window)

		buildWindow()
		buildToolbar()
		buildMainView()

		NotificationCenter.default.addObserver(forName: Self.reveal, object: nil, queue: nil, using: reveal)
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: - NSToolbarDelegate

//extension SettingsWindowController: NSToolbarDelegate {
//	func toolbar(_ toolbar: NSToolbar, itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier, willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
//		switch itemIdentifier {
//			case .tabPicker:
//				let titles = SettingsTab.allCases.map { $0.description }
//				let icons = SettingsTab.allCases.map { NSImage(systemSymbolName: $0.symbolName, accessibilityDescription: $0.description)! }
//
//				let item = NSToolbarItemGroup(itemIdentifier: .tabPicker, images: icons, selectionMode: .selectOne, labels: titles, target: self, action: #selector(toolbarPickerDidSelectItem(_:)))
//				item.controlRepresentation = .expanded
//				item.selectedIndex = 0
//				return item
//			case .displayTab:
//				let item = NSToolbarItem(itemIdentifier: .displayTab)
//				item.target = self
//				item.action = #selector(setTabDisplay(_:))
//				item.title = "Display"
//				item.image = NSImage(systemSymbolName: "display", accessibilityDescription: "Display")
//				return item
//			case .directoriesTab:
//				let item = NSToolbarItem(itemIdentifier: .directoriesTab)
//				item.target = self
//				item.action = #selector(setTabDirectories(_:))
//				item.title = "Directories"
//				item.image = NSImage(systemSymbolName: "folder", accessibilityDescription: "Directories")
//				return item
//			default:
//				return nil
//		}
//	}
//
//	func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] { [
//		.displayTab,
//		.directoriesTab
//	] }
//
//	func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] { [
//		.displayTab,
//		.directoriesTab
//	] }
//}

// MARK: - Creation

private extension SettingsWindowController {
	func buildWindow() {
		guard let window else {
			print("Could not get \(Self.self).window")
			return
		}

		window.title = "App Library Settings"
		window.toolbarStyle = .preference

		window.standardWindowButton(.zoomButton)?.isHidden = true

		self.window = window
	}

	func buildMainView() {
		guard let window else {
			print("Could not get \(Self.self).window")
			return
		}

		let mainView = NSHostingView(rootView: SettingsContentView(windowController: self))
		mainView.translatesAutoresizingMaskIntoConstraints = false

		window.contentView = mainView

		if let contentView = window.contentView {
			mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
			mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
			mainView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
			mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
		}
	}

	func buildToolbar() {
//		guard let window else {
//			print("Could not get \(Self.self).window")
//			return
//		}
//
//		// reference: https://github.com/marioaguzman/toolbar/blob/master/Toolbar/Main%20Window/MainWindowController.swift
//
//		let toolbar = NSToolbar()
//		toolbar.delegate = self
//		toolbar.displayMode = .iconAndLabel
//
//		window.toolbar = toolbar
	}
}

// MARK: - Visibility

extension SettingsWindowController {
	static let reveal: Notification.Name = Notification.Name("SettingsWindowController.Reveal")

	private func reveal(_: Notification) {
		guard let window else {
			print("Could not get \(Self.self).window")
			return
		}

		window.center()
		showWindow(self)
	}

//	@objc func toolbarPickerDidSelectItem(_ sender: Any) {
//		guard
//			let toolbarItemGroup = sender as? NSToolbarItemGroup,
//			toolbarItemGroup.itemIdentifier == .tabPicker,
//			let newActiveTab = SettingsTab(index: toolbarItemGroup.selectedIndex)
//		else {
//			return
//		}
//		activeTab = newActiveTab
//	}
//
//	@objc func setTabDisplay(_ sender: Any?) {
//		activeTab = .display
//	}
//
//	@objc func setTabDirectories(_ sender: Any?) {
//		activeTab = .directories
//	}
}

// MARK: - NSToolbarItem.Identifier

private extension NSToolbarItem.Identifier {
	static let tabPicker: NSToolbarItem.Identifier = .init(rawValue: "AppLibrary.Settings.TabPicker")
	static let displayTab: NSToolbarItem.Identifier = .init(rawValue: "AppLibrary.Settings.Tab.Display")
	static let directoriesTab: NSToolbarItem.Identifier = .init(rawValue: "AppLibrary.Settings.Tab.Directories")
}
