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

	public static func getLocation() -> NSPoint? {
		guard accessGranted else {
			return nil
		}

		var iconOrigin = NSPoint.zero

		if let dockIcon = dockIcon() {
			var values: CFArray?
			if AXUIElementCopyMultipleAttributeValues(
				dockIcon,
				[kAXPositionAttribute as CFString, kAXSizeAttribute as CFString] as CFArray,
				.stopOnError,
				&values
			) == .success {
				var position = CGPoint.zero
				var size = CGSize.zero

				(values as! [AXValue]).forEach { axValue in
					AXValueGetValue(axValue, .cgPoint, &position)
					AXValueGetValue(axValue, .cgSize, &size)
				}

				iconOrigin = NSPoint(
					x: position.x + size.width / 2.0,
					y: NSScreen.main!.frame.height - (position.y + size.height / 2.0)
				)
			}
		}

		return iconOrigin
	}

	/// The accessibility element for the app’s dock tile
	private static func dockIcon() -> AXUIElement? {
		let appsWithDockBundleID = NSRunningApplication.runningApplications(withBundleIdentifier: Self.dockBundleID)

		guard let processID = appsWithDockBundleID.last?.processIdentifier else {
			return nil
		}

		let appElement = AXUIElementCreateApplication(processID)

		guard
			let firstChild = subelements(from: appElement, forAttribute: Self.axChildren)?.first,
			let children = subelements(from: firstChild, forAttribute: Self.axChildren)
		else {
			return nil
		}

		let appName = Bundle.main.object(forInfoDictionaryKey: kCFBundleNameKey as String) as! String

		for axElement in children {
			var value: CFTypeRef?
			if
				AXUIElementCopyAttributeValue(axElement, kAXTitleAttribute as CFString, &value) == .success,
				value as? String == appName
			{
				return axElement
			}
		}
		return nil
	}

	private static func subelements(from element: AXUIElement, forAttribute attribute: String) -> [AXUIElement]? {
		var count: CFIndex = 0
		var subElements: CFArray?

		guard
			AXUIElementGetAttributeValueCount(element, attribute as CFString, &count) == .success,
			AXUIElementCopyAttributeValues(element, attribute as CFString, 0, count, &subElements) == .success
		else {
			return nil
		}

		return subElements as? [AXUIElement]
	}
}

private extension DockTileUtility {
	static let axChildren: String = "AXChildren"
	static let dockBundleID: String = "com.apple.dock"
}
