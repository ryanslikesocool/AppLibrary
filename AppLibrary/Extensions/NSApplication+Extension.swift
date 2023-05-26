import Cocoa

extension NSApplication {
	@objc func orderFrontSettingsPanel(_ sender: Any?) {
		if let delegate = delegate as? AppDelegate {
			_ = delegate.settingsWindowController
		}

		NotificationCenter.default.post(name: SettingsWindowController.reveal, object: nil)
	}
}
