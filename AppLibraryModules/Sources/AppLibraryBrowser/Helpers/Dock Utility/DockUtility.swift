import AppLibraryCommon
import Cocoa
import LocalizationTable
import OSLog

/// from `https://github.com/neilsardesai/Mouse-Finder`

public enum DockUtility {
	public static var accessGranted: Bool {
		AXIsProcessTrusted()
	}

	static func readPrivileges(prompt: Bool) -> Bool {
		let options: NSDictionary = [kAXTrustedCheckOptionPrompt.takeRetainedValue() as NSString: prompt]
		let status = AXIsProcessTrustedWithOptions(options)
		return status
	}

	public static func requestAccess() {
		Logger.dockUtility.debug("Requesting accessibility permission...")

		guard !accessGranted else {
			Logger.dockUtility.debug("Accessibility permission was already granted!")
			return
		}

		let alert = createAlert()

		Logger.dockUtility.debug("Presenting accessibility permission alert.")

		presentAlert()

		func createAlert() -> NSAlert {
			let alert = NSAlert()

			let localizationTable = LocalizationTableResource("AccessibilityRequest")

			alert.messageText = String(localized: "TITLE", table: localizationTable)
			alert.informativeText = String(localized: "DESCRIPTION", table: localizationTable)
			alert.addButton(withTitle: String(localized: "ACTION.DENY", table: localizationTable))
			alert.addButton(withTitle: String(localized: "ACTION.ALLOW", table: localizationTable))

			return alert
		}

		func presentAlert() {
			switch alert.runModal() {
				case .alertFirstButtonReturn:
					Logger.dockUtility.debug("Accessibility permission was denied.")
				case .alertSecondButtonReturn:
					let options = [kAXTrustedCheckOptionPrompt.takeRetainedValue(): true]
					_ = AXIsProcessTrustedWithOptions(options as CFDictionary)
					Logger.dockUtility.debug("Accessibility permission was granted.")
				case let otherOption:
					Logger.dockUtility.error("Unsupported alert button '\(String(describing: otherOption))'.")
			}
		}
	}
}
