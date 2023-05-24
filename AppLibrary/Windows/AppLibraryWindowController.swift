import Cocoa
import SwiftUI

final class AppLibraryWindowController: NSWindowController, ObservableObject {
	@Published var apps: [ApplicationInformation]

	init() {
		apps = []
		let window = NSWindow(
			contentRect: NSRect(x: 0, y: 0, width: 300, height: 450),
			styleMask: [.borderless, .fullSizeContentView, .titled],
			backing: .buffered,
			defer: false
		)

		super.init(window: window)

		prepareWindow()
		prepareBackgroundView()
		prepareMainView()

		NotificationCenter.default.addObserver(forName: Self.reloadApps, object: nil, queue: nil, using: reloadApps)
//		reloadApps()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: - Setup

private extension AppLibraryWindowController {
	func prepareWindow() {
		guard let window else {
			print("Could not get \(Self.self).window")
			return
		}

		window.isMovable = false
		window.level = .popUpMenu
		window.titleVisibility = .hidden
		window.titlebarAppearsTransparent = true
		window.isOpaque = false
		window.backgroundColor = .clear
//		window.hidesOnDeactivate = true // breaks animation
		window.animationBehavior = .none

		window.standardWindowButton(.closeButton)?.isHidden = true
		window.standardWindowButton(.miniaturizeButton)?.isHidden = true
		window.standardWindowButton(.zoomButton)?.isHidden = true
	}

	func prepareBackgroundView() {
		guard let window else {
			print("Could not get \(Self.self).window")
			return
		}

		let visualEffect = NSVisualEffectView()
		visualEffect.translatesAutoresizingMaskIntoConstraints = false
		visualEffect.material = .popover
		visualEffect.state = .active
		visualEffect.wantsLayer = true
		visualEffect.layer?.cornerRadius = 16.0
		visualEffect.layer?.cornerCurve = .continuous

		window.contentView = visualEffect

		if let constraints = window.contentView {
			visualEffect.leadingAnchor.constraint(equalTo: constraints.leadingAnchor).isActive = true
			visualEffect.trailingAnchor.constraint(equalTo: constraints.trailingAnchor).isActive = true
			visualEffect.topAnchor.constraint(equalTo: constraints.topAnchor).isActive = true
			visualEffect.bottomAnchor.constraint(equalTo: constraints.bottomAnchor).isActive = true
		}

		window.invalidateShadow()
	}

	func prepareMainView() {
		guard let contentView = window?.contentView else {
			print("Could not get \(Self.self).window.contentView")
			return
		}

		let mainView = NSHostingView(rootView: ContentView(windowController: self))
		mainView.translatesAutoresizingMaskIntoConstraints = false

		contentView.addSubview(mainView)

		mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
		mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
		mainView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
		mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
	}
}

// MARK: - Apps

extension AppLibraryWindowController {
	static let reloadApps: Notification.Name = Notification.Name("AppLibraryWindowController.ReloadApps")

	private func reloadApps(_ : Notification) {
		let query: NSMetadataQuery = NSMetadataQuery()
		query.searchScopes = [URL](AppSettings.shared.directories.searchScopes)
		let pred: NSPredicate = NSPredicate(format: "kMDItemContentType == 'com.apple.application-bundle'")

		NotificationCenter.default.addObserver(forName: .NSMetadataQueryDidFinishGathering, object: nil, queue: .main, using: recieve)

		query.predicate = pred
		query.start()

		func recieve(notification: Notification) {
			NotificationCenter.default.removeObserver(recieve, name: .NSMetadataQueryDidFinishGathering, object: nil)
			let metadata = query.results.compactMap { $0 as? NSMetadataItem }
			process(metadata: metadata)
		}

		func process(metadata: [NSMetadataItem]) {
			apps = metadata.map { ApplicationInformation(metadata: $0) }
		}
	}
}

// MARK: - Visibility

extension AppLibraryWindowController {
	func reveal() {
		guard let window else {
			print("Could not get \(Self.self).window")
			return
		}
		guard let tileLocation = DockTileUtilities.getLocation() else {
			print("Could not get dock tile location")
			return
		}

		let topLeftPoint: NSPoint = NSPoint(
			x: tileLocation.x - window.frame.width * 0.5,
			y: tileLocation.y * 2.0 + window.frame.height
		)

		window.setFrameTopLeftPoint(topLeftPoint)
		window.makeKeyAndOrderFront(self)
	}

	func dismiss() {
		window?.orderOut(self)
	}

	func hide() {
		NSApplication.shared.hide(self)
	}
}
