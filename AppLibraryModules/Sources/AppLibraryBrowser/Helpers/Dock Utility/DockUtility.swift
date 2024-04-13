import AppLibraryCommon
import Cocoa
import OSLog

/// from `https://github.com/neilsardesai/Mouse-Finder`

public enum DockUtility {
	public static var accessGranted: Bool { AXIsProcessTrusted() }

	static func readPrivileges(prompt: Bool) -> Bool {
		let options: NSDictionary = [kAXTrustedCheckOptionPrompt.takeRetainedValue() as NSString: prompt]
		let status = AXIsProcessTrustedWithOptions(options)
		return status
	}

	public static func requestAccess() {
		Logger.module.debug("Requesting accessibility permission...")

		guard !accessGranted else {
			Logger.module.debug("Accessibility permission was already granted!")
			return
		}

		let alert = NSAlert()

		alert.messageText = "Accessibility Permission Requested"
		alert.informativeText = """
		\(AppLibraryInformation.appName) uses accessibility features to locate the dock icon.
		\(AppLibraryInformation.appName) will continue to function if access is denied.
		"""
		alert.addButton(withTitle: "Cancel")
		alert.addButton(withTitle: "Continue")

		Logger.module.debug("Presenting accessibility permission alert.")

		switch alert.runModal() {
			case .alertFirstButtonReturn:
				Logger.module.debug("Accessibility permission was denied.")
			case .alertSecondButtonReturn:
				let options = [kAXTrustedCheckOptionPrompt.takeRetainedValue(): true]
				_ = AXIsProcessTrustedWithOptions(options as CFDictionary)
				Logger.module.debug("Accessibility permission was granted.")
			case let otherOption:
				Logger.module.error("Unsupported alert button '\(String(describing: otherOption))'.")
		}
	}
}
