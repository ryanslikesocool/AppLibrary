import Cocoa

public extension DockTileUtility {
	static func getIconLocation() -> NSPoint? {
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
}

private extension DockTileUtility {
	/// The accessibility element for the app’s dock tile
	static func dockIcon() -> AXUIElement? {
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

	static func subelements(from element: AXUIElement, forAttribute attribute: String) -> [AXUIElement]? {
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

// MARK: - Constants

private extension DockTileUtility {
	static let axChildren: String = "AXChildren"
	static let dockBundleID: String = "com.apple.dock"
}
