import AppKit
import AppLibraryAccessibilityHelperShared
@preconcurrency import var ApplicationServices.HIServices.kAXTrustedCheckOptionPrompt
import OSLog

// @MainActor
public enum AccessibilityUtility {
	/// Returns whether the current process is a trusted accessibility client.
	public static var isTrusted: Bool {
		AXIsProcessTrusted()
	}

	// TODO: Only request accessibility permisson once.
	// Don't bother the user every time the app launches,
	// even if they deny accessibility permisson.

	/// Show an alert to the user requesting accessibility permission.
	@discardableResult
	public static func requestAccess() -> Bool {
		let prompt = kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String
		let options: NSDictionary = [prompt: true]
		let permissionGranted = AXIsProcessTrustedWithOptions(options)

		if permissionGranted {
			logger.info("Accessibility permission was granted.")
		} else {
			logger.info("Accessibility permission was denied.")
		}

		return permissionGranted
	}
}

// MARK: - Constants

private extension AccessibilityUtility {
	nonisolated static let logger = Logger(category: Self.self)
}
