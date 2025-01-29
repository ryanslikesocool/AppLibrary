import AppKit
import AppLibraryBrowserWindow
import AppLibraryCommon
import AppLibraryStorage
import Combine
import OSLog

@MainActor
final class AppDelegate: NSObject, NSApplicationDelegate {
	private(set) lazy var browserWindowController: BrowserWindowController = BrowserWindowController()

	private lazy var windowWillCloseSubscriber: AnyCancellable = NotificationCenter.default
		.publisher(for: NSWindow.willCloseNotification)
		.compactMap { notification in notification.object as? NSWindow }
		.sink { window in self.windowWillClose(window) }

	func applicationWillFinishLaunching(_ notification: Notification) {
		ActivationPolicyUtility.current = .prohibited
	}

	func applicationDidFinishLaunching(_ notification: Notification) {
		Logger.module.debug("Finished launching \(NSApplication.shared.appName).")

		_ = GeneralSettings.shared
		_ = AppsSettings.shared
		_ = LayoutSettings.shared

		ActivationPolicyUtility.current = .regular
		browserWindowController.reveal()

		_ = windowWillCloseSubscriber
	}

	func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
		false
	}

	func applicationDidBecomeActive(_ notification: Notification) {
		browserWindowController.reveal()
	}

	func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows: Bool) -> Bool {
		browserWindowController.reveal()
		return true
	}
}

// MARK: - Constants

private extension AppDelegate {
	static let excludedWindowIdentifiers: [NSUserInterfaceItemIdentifier] = [
		NSUserInterfaceItemIdentifier(WindowIdentifier.settings),
		NSUserInterfaceItemIdentifier(WindowIdentifier.about),
	]
}

// MARK: -

private extension AppDelegate {
	func windowWillClose(_ window: NSWindow) {
		guard Set(NSApp.windows
			.filter(\.isVisible)
			.compactMap(\.identifier))
			.intersection(Self.excludedWindowIdentifiers)
			.isEmpty
		else {
			return
		}

		NSApp.hide(window)
	}
}
