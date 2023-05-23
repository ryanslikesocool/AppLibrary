import Cocoa
import SwiftUI
import UniformTypeIdentifiers

final class AppLibraryWindow: NSWindow, ObservableObject {
	@Published var apps: [ApplicationInformation]

	init(contentRect: NSRect) {
		apps = []

		super.init(
			contentRect: contentRect,
			styleMask: [.borderless, .fullSizeContentView, .titled],
			backing: .buffered,
			defer: false
		)

		prepareWindow()
		prepareBackgroundView()
		prepareMainView()

		reloadApps()
	}

	override var canBecomeMain: Bool { true }
	override var canBecomeKey: Bool { true }
}

extension AppLibraryWindow {
	func reveal(location: NSPoint) {
		setFrameTopLeftPoint(location)
//		alphaValue = 0

		makeKeyAndOrderFront(nil)

//		animate(opacity: 1, onComplete: nil)

//		DispatchQueue.main.async {
//			self.saveSnapshot()
//		}
	}

	func hide() {
//		animate(opacity: 0) { NSApplication.shared.hide(nil) }
		NSApplication.shared.hide(nil)
	}

	func dismiss() {
//		animate(opacity: 0) { [weak self] in self?.orderOut(nil) }
		orderOut(nil)
	}
}

private extension AppLibraryWindow {
	private static let animationDuration: Double = 0.2

	private func animate(opacity: Double, onComplete: (() -> Void)?) {
		NSAnimationContext.runAnimationGroup({ context in
			context.duration = Self.animationDuration
			animator().alphaValue = opacity
		}, completionHandler: onComplete)
	}

	private func saveSnapshot() {
		guard
			let cgImage: CGImage = makeSnapshot(),
			let dest = CGImageDestinationCreateWithURL(URL.desktopDirectory.appending(component: "snapshot.png") as CFURL, UTType.png.identifier as CFString, 1, nil)
		else {
			return
		}

		CGImageDestinationAddImage(dest, cgImage, nil)
		CGImageDestinationFinalize(dest)
	}

	private func makeSnapshot() -> CGImage? {
		guard contentView != nil else {
			return nil
		}

		let rect: CGRect = CGRect(x: Double.infinity, y: Double.infinity, width: 0, height: 0)

		return CGWindowListCreateImage(rect, .optionIncludingWindow, CGWindowID(windowNumber), .bestResolution)
	}

	private func makeSnapshot() -> NSImage? {
		guard let cgImage: CGImage = makeSnapshot() else {
			return nil
		}

		return NSImage(cgImage: cgImage, size: CGSize(width: cgImage.width, height: cgImage.height))
	}
}

private extension AppLibraryWindow {
	func prepareWindow() {
		isMovable = false
		level = .popUpMenu
		titleVisibility = .hidden
		titlebarAppearsTransparent = true
		isOpaque = false
		backgroundColor = .clear
//		hidesOnDeactivate = true // breaks animation
		animationBehavior = .none

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

		invalidateShadow()
	}

	func prepareMainView() {
		guard let contentView else {
			return
		}

		let mainView = NSHostingView(rootView: ContentView(window: self))
		mainView.translatesAutoresizingMaskIntoConstraints = false

		contentView.addSubview(mainView)

		mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
		mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
		mainView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
		mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
	}

	func reloadApps() {
		TileUtilities.listAllApplications(scopes: [URL](AppSettings.shared.directories.searchScopes), onComplete: { [weak self] metadata in
			self?.apps = metadata.map { ApplicationInformation(metadata: $0) }
		})
	}
}
