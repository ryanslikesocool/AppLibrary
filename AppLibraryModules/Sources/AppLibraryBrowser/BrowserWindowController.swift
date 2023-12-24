import AppKit

public final class BrowserWindowController: NSWindowController, ObservableObject {
	public init() {
		let window = NSPanel(
			contentRect: NSRect(origin: .zero, size: BrowserWindowController.windowSize),
			styleMask: [.borderless, .fullSizeContentView, .nonactivatingPanel, .titled],
			backing: .buffered,
			defer: false
		)

		window.isMovable = false
		window.isFloatingPanel = true
		window.titleVisibility = .hidden
		window.titlebarAppearsTransparent = true
		window.isOpaque = false
		window.backgroundColor = .clear
		window.hidesOnDeactivate = true
		window.standardWindowButton(.closeButton)?.isHidden = true
		window.standardWindowButton(.miniaturizeButton)?.isHidden = true
		window.standardWindowButton(.zoomButton)?.isHidden = true
		window.hidesOnDeactivate = true

		window.contentViewController = BrowserViewController()

		super.init(window: window)

		window.delegate = self
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: - NSWindowDelegate

extension BrowserWindowController: NSWindowDelegate {
	override public func windowDidLoad() {
		window?.invalidateShadow()
	}
}

// MARK: - Constants

extension BrowserWindowController {
	static let windowSize: NSSize = NSSize(width: 300, height: 450)
	static let windowPadding: CGFloat = 8
}

// MARK: -

public extension BrowserWindowController {
	func reveal() {
		guard let window else {
			return
		}
//		NSApp.setActivationPolicy(.accessory)
//		NSApp.setActivationPolicy(.regular)

		if
			let iconRect = DockTileUtility.getIconRect(),
			let dockPosition = DockTileUtility.estimateDockPosition(),
			let screen = NSScreen.main
		{
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
			// invert Y
			frameOrigin.y = screen.frame.height - frameOrigin.y

			window.setFrameOrigin(frameOrigin)
		} else {
			window.center()
		}

		window.makeKeyAndOrderFront(self)
		print("reveal")
	}

	func dismiss() {
		print("dismiss")
//		window?.orderOut(self) // handled by window.hidesOnDeactivate = true
	}
}
