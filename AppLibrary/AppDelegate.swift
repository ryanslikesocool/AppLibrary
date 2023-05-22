import Cocoa
import SwiftUI

final class AppDelegate: NSObject, NSApplicationDelegate {
	private var window: NSWindow!

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

		windowSetup()

//		NSApp.dockTile.contentView = appIconContent
//		NSApp.dockTile.display()

		// createWindow()

//		NSEvent.addLocalMonitorForEvents(
//			matching: [.mouseMoved]
//		) { [weak self] in
//			guard let self = self else { return $0 }
//			self.updateDockTile()
//			NSApp.dockTile.display()
//			return $0
//		}
	}

	func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
		false
	}

	func applicationDidBecomeActive(_ notification: Notification) {
		openWindow()
	}

	func applicationDidResignActive(_ notification: Notification) {
		closeWindow()
	}
}

extension AppDelegate {
	private func openWindow() {
		guard let tileLocation = getTileLocation() else {
			return
		}

		window.setFrameTopLeftPoint(NSPoint(
			x: tileLocation.x - window.frame.width * 0.5,
			y: tileLocation.y * 2.0 + window.frame.height
		))
		DispatchQueue.main.async { [weak self] in
			self?.window.makeKeyAndOrderFront(nil)
		}
	}

	private func closeWindow() { }

	private func windowSetup() {
		window = NSWindow(
			contentRect: NSRect(x: 0, y: 0, width: 300, height: 450),
			styleMask: [.borderless, .closable, .titled],
			backing: .buffered,
			defer: false
		)
		window.isMovable = false
		window.titleVisibility = .hidden
		window.titlebarAppearsTransparent = true
		window.isOpaque = false
		window.backgroundColor = .clear
		window.hidesOnDeactivate = true

		window.standardWindowButton(.closeButton)?.isHidden = true
		window.standardWindowButton(.miniaturizeButton)?.isHidden = true
		window.standardWindowButton(.zoomButton)?.isHidden = true

		let view = NSHostingView(rootView: ContentView())
		view.wantsLayer = true
		view.layer!.cornerRadius = 16
		view.layer!.cornerCurve = .continuous
		view.layer!.masksToBounds = true

		window.contentView = view

		window.invalidateShadow()
	}
}

extension AppDelegate {
	private func getTileLocation() -> CGPoint? {
		guard AXIsProcessTrusted() else {
			return nil
		}

		var iconOrigin = NSPoint.zero
//		let mouseLocation = NSEvent.mouseLocation

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

				// If the pointer is overlapping the icon
//				if mouseLocation.x >= position.x
//					&& mouseLocation.x <= position.x + size.width
//					&& mouseLocation.y <= NSScreen.main!.frame.height - position.y
//					&& mouseLocation.y >= NSScreen.main!.frame.height - position.y - size.height
//				{
//					performHoverAnimation()
//					return
//				} else {
//					hoverAnimationTimer?.invalidate()
//					hoverAnimationTimer = nil
//					eyes.isHidden = false
//					contentView.image = NSImage(named: .base)
//				}
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
