import AppLibraryAboutWindow
import AppLibraryBrowserWindow
import AppLibraryCommon
import AppLibrarySettingsWindow
import OSLog
import SwiftUI

@main
public struct App: SwiftUI.App {
	@NSApplicationDelegateAdaptor private var appDelegate: AppDelegate

//	@Environment(\.scenePhase) private var scenePhase

	public init() {
		Logger.module.debug("Started launching \(NSApplication.shared.applicationName).")
	}

	public var body: some Scene {
		SettingsWindow()
			.commands {
				MainMenu()
			}
//			.onChange(of: scenePhase) {
//				// NOTE: This modifier also affects the `About` window.
//
//				switch scenePhase {
//					case .active, .inactive: ActivationPolicyUtility.current = .regular
//					case .background: ActivationPolicyUtility.current = .accessory
//					@unknown default: break
//				}
//			}

		AboutWindow()
	}
}
