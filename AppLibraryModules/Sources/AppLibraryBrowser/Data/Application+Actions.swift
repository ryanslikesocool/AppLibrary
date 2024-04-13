import AppKit
import AppLibraryStorage

extension Application {
	func open() {
		guard let url = getURL() else {
			return
		}
		NSWorkspace.shared.openApplication(at: url, configuration: Self.openApplicationConfiguration)
	}

	func showInFinder() {
		getURL()?.showInFinder()
	}

	func hide() {
		AppSettings.shared.apps.tryAddHiddenApp(withIdentifier: id)
		AppSettings.shared.apps.save()
	}
}

// MARK: - Constants

private extension Application {
	static let openApplicationConfiguration: NSWorkspace.OpenConfiguration = NSWorkspace.OpenConfiguration()
}
