import AppKit
import AppLibraryCommonViews

final class BrowserWindow: NSVisualEffectPanel {
	override func becomeKey() {
		Task { @MainActor in
			NSApp.activate()
		}
		super.becomeKey()
	}

	override func resignKey() {
		close()
	}

	override func cancelOperation(_ sender: Any?) {
		close()
	}
}
