import AppKit

public final class BrowserWindowController: NSWindowController, ObservableObject {
	public init() {
		let window = NSPanel(
			contentRect: NSRect(origin: .zero, size: BrowserWindowController.windowSize),
			styleMask: [.borderless, .fullSizeContentView, .nonactivatingPanel, .titled],
			backing: .buffered,
			defer: false
		)

		window.title = "Browser"
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
}

// MARK: -

public extension BrowserWindowController {
	func reveal() {
		//		NSApp.setActivationPolicy(.accessory)

		if let dockPosition = DockTileUtility.getLocation() {
			window?.setFrameOrigin(dockPosition)
		} else {
			window?.center()
		}

		window?.makeKeyAndOrderFront(self)
//		NSApp.setActivationPolicy(.regular)
	}

	func dismiss() {
		print("dismiss")
//		window?.orderOut(self) // handled by window.hidesOnDeactivate = true
	}
}
