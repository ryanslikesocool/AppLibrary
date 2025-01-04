import AppKit
import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryDockUtility
import AppLibraryResources
import OSLog
import SwiftUI

public final class BrowserWindowController: NSWindowController, ObservableObject {
	private let browserModel: BrowserModel

	public init() {
		browserModel = BrowserModel()

		// TODO: Should this be a panel?
		let window = NSVisualEffectWindow(
			contentRect: NSRect(origin: .zero, size: BrowserWindowController.windowSize),
			styleMask: [.titled, .fullSizeContentView, .nonactivatingPanel],
			defer: false
		)
		window.identifier = Self.windowIdentifier

		super.init(window: window)

		window.delegate = self
		window.title = LocalizedStringResource.browserWindow.title
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
	static let logger: Logger = Logger(category: BrowserWindowController.self)

	static let windowSize: CGSize = CGSize(width: 300, height: 450)

	/// The padding from the edge of the window to the dock.
	///
	/// The accessibility API used to calculate the position the window automatically adds some padding by default.
	static let windowPadding: CGFloat = 0

	static let windowIdentifier: NSUserInterfaceItemIdentifier = NSUserInterfaceItemIdentifier(WindowIdentifier.appLibrary)
}

// MARK: -

public extension BrowserWindowController {
	func reveal() {
		guard let window else {
			Self.logger.debug("Browser window does not exist.  This should not happen.")
			return
		}
//		NSApp.setActivationPolicy(.accessory)
//		NSApp.setActivationPolicy(.regular)

		positionWindow(window)

		DispatchQueue.main.async {
			window.makeKeyAndOrderFront(self)
			Self.logger.debug("Revealed browser.")
		}
	}

	func dismiss() {
		Self.logger.debug("Dismissed browser.")
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
			Self.logger.debug("""
			Failed to get dock icon location for window positioning.
			The window will be centered instead.
			""")
		}
	}

	/// - Parameter screen: The screen the window will be displayed on.
	/// Leave this `nil` to use `NSScreen.main`.
	static func calculateWindowOrigin(on screen: NSScreen? = nil) -> CGPoint? {
		guard
			let screen = screen ?? NSScreen.main,
			let dock = Dock.main,
			let iconRect = DockTile.main(in: dock)?.rect,
			let (dockRect, dockEdge) = dock.rectAndEstimatedEdge(on: screen)
		else {
			return nil
		}

		var frameOrigin = switch dockEdge {
			case .left:
				CGPoint(
					x: dockRect.maxX + windowPadding,
					y: iconRect.midY + windowSize.height * 0.5
				)
			case .bottom:
				CGPoint(
					x: iconRect.midX - windowSize.width * 0.5,
					y: dockRect.minY - windowPadding
				)
			case .right:
				CGPoint(
					x: dockRect.minX - (windowSize.width + windowPadding),
					y: iconRect.midY + windowSize.height * 0.5
				)
		}

		frameOrigin.y = screen.frame.height - frameOrigin.y // invert Y

		return frameOrigin
	}
}
