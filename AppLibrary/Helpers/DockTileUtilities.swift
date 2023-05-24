import Cocoa

enum DockTileUtilities {
	static func getLocation() -> NSPoint? {
		guard AXIsProcessTrusted() else {
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
		let appsWithDockBundleID = NSRunningApplication.runningApplications(withBundleIdentifier: .dockBundleID)
		guard let processID = appsWithDockBundleID.last?.processIdentifier else { return nil }
		let appElement = AXUIElementCreateApplication(processID)
		guard let firstChild = subelements(from: appElement, forAttribute: .axChildren)?.first else { return nil }
		// Reverse to avoid picking up the real Finder in case it’s in the Dock.
		guard let children = subelements(from: firstChild, forAttribute: .axChildren)?.reversed() else { return nil }
		for axElement in children {
			var value: CFTypeRef?
			if AXUIElementCopyAttributeValue(axElement, kAXTitleAttribute as CFString, &value) == .success {
				let appName = Bundle.main.object(forInfoDictionaryKey: kCFBundleNameKey as String) as! String
				if value as? String == appName { return axElement }
			}
		}
		return nil
	}

	private static func subelements(from element: AXUIElement, forAttribute attribute: String) -> [AXUIElement]? {
		var subElements: CFArray?
		var count: CFIndex = 0
		if AXUIElementGetAttributeValueCount(element, attribute as CFString, &count) != .success {
			return nil
		}
		if AXUIElementCopyAttributeValues(element, attribute as CFString, 0, count, &subElements) != .success {
			return nil
		}
		return subElements as? [AXUIElement]
	}
}

private extension String {
	static let axChildren = "AXChildren"
	static let dockBundleID = "com.apple.dock"
}
