import Cocoa

public extension DockTileUtility {
	static func getIconLocation() -> CGPoint? {
		guard let iconRect = getIconRect() else {
			return nil
		}

		return CGPoint(
			x: iconRect.origin.x + iconRect.width * 0.5,
			y: NSScreen.main!.frame.height - (iconRect.origin.y + iconRect.height * 0.5)
		)
	}

	static func getIconRect() -> CGRect? {
		guard
			accessGranted,
			let dockIcon = dockIcon()
		else {
			return nil
		}

		var values: CFArray?
		guard AXUIElementCopyMultipleAttributeValues(
			dockIcon,
			[kAXPositionAttribute as CFString, kAXSizeAttribute as CFString] as CFArray,
			.stopOnError,
			&values
		) == .success else {
			return nil
		}

		var origin = CGPoint.zero
		var size = CGSize.zero

		(values as! [AXValue]).forEach { axValue in
			AXValueGetValue(axValue, .cgPoint, &origin)
			AXValueGetValue(axValue, .cgSize, &size)
		}

		return CGRect(origin: origin, size: size)
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
