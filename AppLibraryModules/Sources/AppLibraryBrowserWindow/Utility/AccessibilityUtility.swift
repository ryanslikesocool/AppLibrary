import AppKit
internal import AppLibraryLocalization
import OSLog

public enum AccessibilityUtility {
	/// Returns whether the current process is a trusted accessibility client.
	public static var isTrusted: Bool {
		AXIsProcessTrusted()
	}

//	static func readPrivileges(prompt: Bool) -> Bool {
//		let options: NSDictionary = [kAXTrustedCheckOptionPrompt.takeRetainedValue() as NSString: prompt]
//		let status = AXIsProcessTrustedWithOptions(options)
//		return status
//	}

	/// Show an alert to the user requesting accessibility permission.
	public static func requestAccess() {
		logger.info("Requesting accessibility permission...")

		guard !isTrusted else {
			logger.info("Accessibility permission was already granted.")
			return
		}

		let alert = createAlert()

		logger.info("Presenting accessibility permission alert.")

		presentAlert()

		func createAlert() -> NSAlert {
			let alert = NSAlert()

			alert.alertStyle = .informational
			alert.messageText = String(localized: .accessibilityRequest.title)
			alert.informativeText = String(localized: .accessibilityRequest.description)
			/* let denyButton = */ alert.addButton(withTitle: String(localized: .accessibilityRequest.action.deny))
			/* let allowButton = */ alert.addButton(withTitle: String(localized: .accessibilityRequest.action.allow))

			return alert
		}

		func presentAlert() {
			switch alert.runModal() {
				case .cancel, .alertFirstButtonReturn:
					logger.info("Accessibility permission was denied.")
				case .alertSecondButtonReturn:
					let options = [kAXTrustedCheckOptionPrompt.takeRetainedValue(): true]
					_ = AXIsProcessTrustedWithOptions(options as CFDictionary)
					logger.info("Accessibility permission was granted.")
				case let otherOption:
					logger.error("Unsupported alert button '\(String(describing: otherOption))'.")
			}
		}
	}
}

// MARK: - Constants

private extension AccessibilityUtility {
	static let logger: Logger = Logger(category: Self.self)
}
