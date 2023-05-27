import Cocoa
import SwiftUI

final class AppLibraryWindowController: NSWindowController, ObservableObject {
	@Published var apps: [ApplicationInformation]

	init() {
		apps = []
		
		let window = AppLibraryPanel(
			contentRect: NSRect(x: 0, y: 0, width: 300, height: 450)
		)

		super.init(window: window)

		buildMainView()

		NotificationCenter.default.addObserver(forName: Self.reloadApps, object: nil, queue: nil, using: reloadApps)
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: - Setup

private extension AppLibraryWindowController {
	func buildMainView() {
		guard let contentView = window?.contentView else {
			print("Could not get \(Self.self).window.contentView")
			return
		}

		let mainView = NSHostingView(rootView: AppLibraryContentView(windowController: self))
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

	private func reloadApps(_: Notification) {
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

		let origin: NSPoint = NSPoint(
			x: tileLocation.x - window.frame.width * 0.5,
			y: tileLocation.y * 2.0
		)

		window.setFrameOrigin(origin)
		window.makeKeyAndOrderFront(self)
	}

	func dismiss() {
		window?.orderOut(self)
	}

	func hide() {
		NSApplication.shared.hide(self)
	}
}
