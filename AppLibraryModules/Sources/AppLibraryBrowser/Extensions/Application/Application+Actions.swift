import AppKit
import OSLog
import AppLibraryStorage

extension Application {
	func open() {
		guard let url else {
			Logger.module.warning("Failed to access `url` for application with bundle identifier '\(bundleIdentifier)'.")
			return
		}

		NSWorkspace.shared.openApplication(
			at: url,
			configuration: Self.openApplicationConfiguration
		)
	}

	func showInFinder() {
		guard let url else {
			Logger.module.warning("Failed to access `url` for application with bundle identifier '\(bundleIdentifier)'.")
			return
		}

		url.showInFinder()
	}

	@MainActor
	func hide() {
		AppsSettings.shared.hideApplication(with: id)
	}
}

// MARK: - Constants

private extension Application {
	static let openApplicationConfiguration: NSWorkspace.OpenConfiguration = NSWorkspace.OpenConfiguration()
}
