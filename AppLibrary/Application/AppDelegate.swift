import Carbon.HIToolbox
import Cocoa
import SwiftUI

final class AppDelegate: NSObject, NSApplicationDelegate {
	private lazy var window: NSWindow = AppLibraryWindow(contentRect: NSRect(x: 0, y: 0, width: 300, height: 450))

	private let appIconContent: NSImageView = NSImageView(image: NSImage(named: "AppIcon")!)

	func applicationDidFinishLaunching(_ notification: Notification) {
		if !AXIsProcessTrusted() {
			let alert = NSAlert()
			alert.messageText = "Accessibility Permission Needed"
			alert.informativeText = "App Library uses accessibility features to locate the dock icon."
			alert.addButton(withTitle: "Continue")
			if alert.runModal() == .alertFirstButtonReturn {
				let options = [kAXTrustedCheckOptionPrompt.takeRetainedValue(): true]
				_ = AXIsProcessTrustedWithOptions(options as CFDictionary)
			}
		}

		_ = AppSettings.shared

		NSEvent.addLocalMonitorForEvents(matching: .keyDown) {
			if self.keyDown(with: $0) {
				return nil // needed to get rid of purr sound
			} else {
				return $0
			}
		}
	}

	func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
		false
	}

//	func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
//		true
//	}

	func applicationDidBecomeActive(_ notification: Notification) {
		revealWindow()
	}

	func applicationDidResignActive(_ notification: Notification) {
		dismissWindow()
	}
}

private extension AppDelegate {
	func revealWindow() {
		guard let tileLocation = getTileLocation() else {
			return
		}

		window.setFrameTopLeftPoint(NSPoint(
			x: tileLocation.x - window.frame.width * 0.5,
			y: tileLocation.y * 2.0 + window.frame.height
		))
		window.makeKeyAndOrderFront(nil)
	}

	func hideApplication() {
		NSApplication.shared.hide(self)
	}

	func dismissWindow() {
		window.orderOut(self)
	}

	func keyDown(with event: NSEvent) -> Bool {
		if Int(event.keyCode) == kVK_Escape {
			hideApplication()
			return true
		} else {
			return false
		}
	}

	func getTileLocation() -> NSPoint? {
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
}

// MARK: - Accessibility Helpers

extension AppDelegate {
	/// The accessibility element for the app’s dock tile
	private func dockIcon() -> AXUIElement? {
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

	private func subelements(from element: AXUIElement, forAttribute attribute: String) -> [AXUIElement]? {
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
