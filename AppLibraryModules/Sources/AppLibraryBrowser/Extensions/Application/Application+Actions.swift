import AppKit
import AppLibraryStorage

extension Application {
	func open() {
		guard let url else {
			return
		}
		NSWorkspace.shared.openApplication(at: url, configuration: Self.openApplicationConfiguration)
	}

	func showInFinder() {
		url?.showInFinder()
	}

	func hide() {
		AppsSettings.shared.hideApplication(with: id)
		AppsSettings.shared.save()
	}
}

// MARK: - Constants

private extension Application {
	static let openApplicationConfiguration: NSWorkspace.OpenConfiguration = NSWorkspace.OpenConfiguration()
}
