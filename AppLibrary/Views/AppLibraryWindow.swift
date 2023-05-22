import Cocoa
import SwiftUI

final class AppLibraryWindow: NSWindow {
	init(contentRect: NSRect) {
		super.init(
			contentRect: contentRect,
			styleMask: [.borderless, .utilityWindow, .fullSizeContentView, .titled],
			backing: .buffered,
			defer: false
		)

		prepareWindow()
		prepareBackgroundView()
		prepareMainView()

		invalidateShadow()
	}

	override var canBecomeMain: Bool { true }
	override var canBecomeKey: Bool { true }
}

private extension AppLibraryWindow {
	func prepareWindow(){
		isMovable = false
		level = .popUpMenu
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
		visualEffect.material = .popover
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
	}

	func prepareMainView() {
		guard let contentView else {
			return
		}

		let mainView = NSHostingView(rootView: ContentView())
		mainView.translatesAutoresizingMaskIntoConstraints = false

		contentView.addSubview(mainView)

		mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
		mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
		mainView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
		mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
	}
}
