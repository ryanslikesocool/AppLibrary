import AppKit
import AppLibraryStorage
import OSLog

extension ApplicationModel {
	func openLatest() {
		guard let url = latestInstance?.url else {
			Logger.module.warning("""
			Failed to get URL for latest version of application:
			- Bundle Identifier: \(self.bundleIdentifier)
			""")
			return
		}

		NSWorkspace.shared.openApplication(
			at: url,
			configuration: Self.openApplicationConfiguration
		)
	}

	func showLatestInFinder() {
		guard let url = latestInstance?.url else {
			Logger.module.warning("""
			Failed to get URL for latest version of application:
			- Bundle Identifier: \(self.bundleIdentifier)
			""")
			return
		}

		url.showInFinder()
	}

	@MainActor
	func hide() {
		AppsSettings.shared.hideApplication(with: ApplicationModelIdentifier(self))
	}
}

// MARK: - Constants

private extension ApplicationModel {
	static let openApplicationConfiguration: NSWorkspace.OpenConfiguration = NSWorkspace.OpenConfiguration()
}
