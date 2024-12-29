import AppKit
import AppLibraryRuntimeModel
import AppLibraryStorage
import OSLog

extension ApplicationModel {
	func openLatest() {
		guard let url = latestInstance?.url else {
			Self.logMissingLatestURL(bundleIdentifier)
			return
		}

		NSWorkspace.shared.openApplication(
			at: url,
			configuration: Self.openApplicationConfiguration
		)
	}

	func showLatestInFinder() {
		guard let url = latestInstance?.url else {
			Self.logMissingLatestURL(bundleIdentifier)
			return
		}

		url.showInFinder()
	}
}

// MARK: - Utility

private extension ApplicationModel {
	static func logMissingLatestURL(_ bundleIdentifier: String) {
		Logger.module.warning("""
		Failed to get URL for latest version of application:
		- Bundle Identifier: \(bundleIdentifier)
		""")
	}
}

// MARK: - Constants

private extension ApplicationModel {
	static let openApplicationConfiguration: NSWorkspace.OpenConfiguration = NSWorkspace.OpenConfiguration()
}
