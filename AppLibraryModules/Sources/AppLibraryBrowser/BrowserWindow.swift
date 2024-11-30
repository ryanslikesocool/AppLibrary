import AppKit

final class BrowserWindow: NSWindow {
	private var childContentView: NSView?

	override init(
		contentRect: NSRect,
		styleMask style: NSWindow.StyleMask,
		backing backingStoreType: NSWindow.BackingStoreType,
		defer flag: Bool
	) {
		super.init(
			contentRect: contentRect,
			styleMask: style.union(.borderless),
			backing: backingStoreType,
			defer: flag
		)

		isOpaque = false
		backgroundColor = .clear
		isMovable = false
		titleVisibility = .hidden
		titlebarAppearsTransparent = true
		level = .floating
		hidesOnDeactivate = true
	}

	override var canBecomeKey: Bool { true }
	override var canBecomeMain: Bool { true }

	override var contentView: NSView? {
		get { childContentView }
		set {
			if newValue == childContentView {
				return
			}

			let bounds: NSRect = NSRect(origin: .zero, size: frame.size)

			var frameView = super.contentView
			if frameView == nil {
				let backgroundView = NSVisualEffectView()
				backgroundView.blendingMode = .behindWindow
				backgroundView.material = .headerView
				backgroundView.wantsLayer = true
				backgroundView.layer?.masksToBounds = true
				backgroundView.layer?.backgroundColor = .clear
				backgroundView.layer?.cornerCurve = .continuous
				backgroundView.layer?.cornerRadius = BrowserWindowShape.cornerRadius
				backgroundView.layer?.borderColor = NSColor.separatorColor.cgColor
				backgroundView.layer?.borderWidth = 1

				frameView = backgroundView

				super.contentView = frameView
			}

			if let childContentView {
				childContentView.removeFromSuperview()
			}
			childContentView = newValue
			childContentView?.frame = contentRect(forFrameRect: bounds)
			childContentView?.autoresizingMask = [.width, .height]
			frameView?.addSubview(childContentView!)
		}
	}
}