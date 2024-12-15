import AppKit

extension NSWindow {
	static func createVisualEffectBackgroundView() -> NSView {
		let backgroundView = NSVisualEffectView()
		backgroundView.blendingMode = .behindWindow
		backgroundView.material = .underWindowBackground
		backgroundView.state = .followsWindowActiveState
		backgroundView.wantsLayer = true

		guard let layer = backgroundView.layer else {
			preconditionFailure("Failed to access the view layer.")
		}

//		layer.masksToBounds = true
//		layer.backgroundColor = .clear
		layer.cornerCurve = .continuous
//		layer.cornerRadius = 0

		return backgroundView
	}
}