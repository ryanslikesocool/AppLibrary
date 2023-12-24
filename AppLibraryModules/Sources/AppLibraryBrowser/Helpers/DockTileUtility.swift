import AppLibraryCommon
import Cocoa

/// from `https://github.com/neilsardesai/Mouse-Finder`

public enum DockTileUtility {
	public static var accessGranted: Bool { AXIsProcessTrusted() }

	static func readPrivileges(prompt: Bool) -> Bool {
		let options: NSDictionary = [kAXTrustedCheckOptionPrompt.takeRetainedValue() as NSString: prompt]
		let status = AXIsProcessTrustedWithOptions(options)
		return status
	}

	public static func requestAccess() {
		guard !accessGranted else {
			return
		}

		let alert = NSAlert()

		alert.messageText = "Accessibility Permission Needed"
		alert.informativeText = "\(AppLibraryInformation.appName) uses accessibility features to locate the dock icon."
		alert.addButton(withTitle: "Continue")

		if alert.runModal() == .alertFirstButtonReturn {
			let options = [kAXTrustedCheckOptionPrompt.takeRetainedValue(): true]
			_ = AXIsProcessTrustedWithOptions(options as CFDictionary)
		}
	}
}
