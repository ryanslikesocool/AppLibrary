import Cocoa

extension NSApplication {
	@objc func orderFrontSettingsPanel(_ sender: Any?) {
		guard let delegate = delegate as? AppDelegate else {
			return
		}

		_ = delegate.settingsWindowController

		delegate.settingsWindowController.show()

//		delegate.settingsWindowController.window?.center()
//		delegate.settingsWindowController.window?.makeKeyAndOrderFront(self)
	}
}
