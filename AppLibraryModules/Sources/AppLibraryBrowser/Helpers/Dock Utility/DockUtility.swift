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
		logger.debug("Requesting accessibility permission...")

		guard !accessGranted else {
			logger.debug("Accessibility permission was already granted!")
			return
		}

		let alert = createAlert()

		logger.debug("Presenting accessibility permission alert.")

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
					logger.debug("Accessibility permission was denied.")
				case .alertSecondButtonReturn:
					let options = [kAXTrustedCheckOptionPrompt.takeRetainedValue(): true]
					_ = AXIsProcessTrustedWithOptions(options as CFDictionary)
					logger.debug("Accessibility permission was granted.")
				case let otherOption:
					logger.error("Unsupported alert button '\(String(describing: otherOption))'.")
			}
		}
	}
}

// MARK: - Constants

private extension DockUtility {
	static let logger: Logger = Logger(category: Self.self)
}
