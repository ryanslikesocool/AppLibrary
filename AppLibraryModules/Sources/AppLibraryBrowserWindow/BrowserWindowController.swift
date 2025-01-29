import AppKit
import AppLibraryAccessibilityHelperServer
import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryResources
import Combine
import OSLog
import SwiftUI

public final class BrowserWindowController: NSWindowController, ObservableObject {
	private let browserModel: BrowserModel

	private lazy var windowVisibilitySubscriber: AnyCancellable = Event.windowVisibility
		.filter(windowIdentifier: Self.windowIdentifier)
		.sink { _, message in self.receive(windowVisibilityMessage: message) }

	public init() {
		browserModel = BrowserModel()

		let window = BrowserWindow(
			contentRect: NSRect(origin: .zero, size: BrowserWindowController.windowSize),
			styleMask: [.titled, .fullSizeContentView, .nonactivatingPanel],
			defer: false
		)
		window.identifier = NSUserInterfaceItemIdentifier(Self.windowIdentifier)

		super.init(window: window)

		window.title = LocalizedStringResource.browserWindow.title
		window.titleVisibility = .hidden
		window.titlebarAppearsTransparent = true
		window.isExcludedFromWindowsMenu = true
		window.level = .modalPanel
		window.isReleasedWhenClosed = false
		window.isMovable = false

		window.material = .popover

		window.contentView = NSHostingView(rootView:
			ContentView(browserModel: browserModel)
		)

		positionWindow(window)

		_ = windowVisibilitySubscriber
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: - Constants

extension BrowserWindowController {
	nonisolated static let logger: Logger = Logger(category: BrowserWindowController.self)

	nonisolated static let windowSize: CGSize = CGSize(width: 300, height: 450)

	/// The padding from the edge of the window to the dock.
	///
	/// The accessibility API used to calculate the position the window automatically adds some padding by default.
	nonisolated static let windowPadding: CGFloat = 0

	nonisolated static let windowIdentifier = WindowIdentifier.browser
}

// MARK: -

public extension BrowserWindowController {
	func reveal() {
		guard let window else {
			Self.logger.debug("Browser window does not exist.  This should not happen.")
			return
		}

		positionWindow(window)

		DispatchQueue.main.async {
			window.makeKeyAndOrderFront(self)
			Self.logger.debug("Revealed browser.")
		}
	}

	func dismiss() {
		guard let window else {
			Self.logger.debug("Browser window does not exist.  This should not happen.")
			return
		}

		window.orderOut(self)
		Self.logger.debug("Dismissed browser.")
	}

	private func receive(windowVisibilityMessage message: WindowVisibilityMessage) {
		switch message {
			case .reveal: reveal()
			case .dismiss: dismiss()
		}
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
		let accessibilityHelper = AccessibilityHelperServer.shared

		guard
			let screen = screen ?? NSScreen.main,
			let iconRect = try? accessibilityHelper.requestDockTileRect(for: Bundle.main),
			let (dockRect, dockEdge) = try? accessibilityHelper.requestRectAndEstimatedEdge(screen: screen)
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
