import Cocoa

final class AppLibraryPanel: NSPanel {
	init(contentRect: NSRect) {
		super.init(
			contentRect: contentRect,
			styleMask: [.borderless, .fullSizeContentView, .nonactivatingPanel, .titled],
			backing: .buffered,
			defer: false
		)

		preparePanel()
		prepareBackgroundView()
	}
}

// MARK: - Setup

private extension AppLibraryPanel {
	func preparePanel() {
		isMovable = false
		isFloatingPanel = true
		titleVisibility = .hidden
		titlebarAppearsTransparent = true
		isOpaque = false
		backgroundColor = .clear
		hidesOnDeactivate = true

		standardWindowButton(.closeButton)?.isHidden = true
		standardWindowButton(.miniaturizeButton)?.isHidden = true
		standardWindowButton(.zoomButton)?.isHidden = true
	}

	func prepareBackgroundView() {
		let visualEffect = NSVisualEffectView()
		visualEffect.translatesAutoresizingMaskIntoConstraints = false
		visualEffect.material = .sidebar
		visualEffect.state = .active
		visualEffect.wantsLayer = true
		visualEffect.layer?.cornerRadius = 16.0
		visualEffect.layer?.cornerCurve = .continuous

		contentView = visualEffect

		if let constraints = contentView {
			visualEffect.leadingAnchor.constraint(equalTo: constraints.leadingAnchor).isActive = true
			visualEffect.trailingAnchor.constraint(equalTo: constraints.trailingAnchor).isActive = true
			visualEffect.topAnchor.constraint(equalTo: constraints.topAnchor).isActive = true
			visualEffect.bottomAnchor.constraint(equalTo: constraints.bottomAnchor).isActive = true
		}

		invalidateShadow()
	}
}
