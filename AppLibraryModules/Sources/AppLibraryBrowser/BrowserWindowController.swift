import AppKit
import AppLibraryCommon
import AppLibraryCommonViews
import LocalizationTable
import OSLog
import SwiftUI

public final class BrowserWindowController: NSWindowController, ObservableObject {
	private let browserModel: BrowserModel

	public init() {
		browserModel = BrowserModel()

		let window = NSVisualEffectWindow(
			contentRect: NSRect(origin: .zero, size: BrowserWindowController.windowSize),
			styleMask: [.titled, .fullSizeContentView, .nonactivatingPanel],
			defer: false
		)
		window.identifier = Self.windowIdentifier

		super.init(window: window)

		window.delegate = self
		window.title = String(localized: "BROWSER_WINDOW.TITLE", table: .common)
		window.titleVisibility = .hidden
		window.titlebarAppearsTransparent = true
		window.isExcludedFromWindowsMenu = true
		window.level = .floating
		window.isMovable = false

		window.material = .menu

		window.contentView = NSHostingView(rootView:
			ContentView(browserModel: browserModel)
		)

		positionWindow(window)
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: - NSWindowDelegate

extension BrowserWindowController: NSWindowDelegate {
	public func windowDidResignKey(_ notification: Notification) {
		dismiss()
		browserModel.keyboardObserver.destroyEventMonitor()
	}

	public func windowDidBecomeKey(_ notification: Notification) {
		browserModel.keyboardObserver.createEventMonitor()
	}
}

// MARK: - Constants

extension BrowserWindowController {
	static let windowSize: NSSize = NSSize(width: 300, height: 450)
	static let windowPadding: CGFloat = 8

	static let windowIdentifier: NSUserInterfaceItemIdentifier = NSUserInterfaceItemIdentifier(WindowIdentifier.appLibrary)
}

// MARK: -

public extension BrowserWindowController {
	func reveal() {
		guard let window else {
			Logger.module.debug("Browser window does not exist.  This should never happen.")
			return
		}
//		NSApp.setActivationPolicy(.accessory)
//		NSApp.setActivationPolicy(.regular)

		positionWindow(window)

		DispatchQueue.main.async {
			window.makeKeyAndOrderFront(self)
			Logger.module.debug("Revealed browser.")
		}
	}

	func dismiss() {
		Logger.module.debug("Dismissed browser.")
		window?.orderOut(self)
	}
}

// MARK: -

private extension BrowserWindowController {
	func positionWindow(_ window: NSWindow) {
		if let windowOrigin = Self.calculateWindowOrigin() {
			window.setFrameOrigin(windowOrigin)
		} else {
			window.center()
			Logger.module.debug("""
			Failed to get dock icon location for window positioning.
			The window will be centered instead.
			""")
		}
	}

	static func calculateWindowOrigin() -> CGPoint? {
		guard
			let iconRect = DockTile.main?.rect,
			let screen = NSScreen.main,
			let dockPosition = screen.estimatedDockPosition
		else {
			return nil
		}

		var frameOrigin = switch dockPosition {
			case .left:
				CGPoint(
					x: iconRect.origin.x + iconRect.width + Self.windowPadding,
					y: iconRect.origin.y + (iconRect.height + Self.windowSize.height) * 0.5
				)
			case .bottom:
				CGPoint(
					x: iconRect.origin.x + (iconRect.width - Self.windowSize.width) * 0.5,
					y: iconRect.origin.y - Self.windowPadding
				)
			case .right:
				// The gap between the dock and window is a little wider due to the accessibility API returning a rect with the origin off a little bit.
				CGPoint(
					x: iconRect.origin.x - (Self.windowSize.width + Self.windowPadding),
					y: iconRect.origin.y + (iconRect.height + Self.windowSize.height) * 0.5
				)
		}

		frameOrigin.y = screen.frame.height - frameOrigin.y // invert Y

		return frameOrigin
	}
}
