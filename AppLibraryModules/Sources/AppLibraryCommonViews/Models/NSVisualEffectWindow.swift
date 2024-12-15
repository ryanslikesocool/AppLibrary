import AppKit
import SwiftUI

open class NSVisualEffectWindow: NSWindow {
	private var childContentView: NSView?

	/// The underlying ``NSVisualEffectView`` of the panel.
	private var visualEffectView: NSVisualEffectView? {
		super.contentView as? NSVisualEffectView
	}

	/// The material shown by the visual effect.
	public var material: NSVisualEffectView.Material! {
		get { visualEffectView?.material }
		set { visualEffectView?.material = newValue }
	}

	/// Constants to specify how the material appearance should reflect window activity state.
	public var state: NSVisualEffectView.State! {
		get { visualEffectView?.state }
		set { visualEffectView?.state = newValue }
	}

	/// A Boolean value indicating whether to emphasize the look of the material.
	public var isEmphasized: Bool! {
		get { visualEffectView?.isEmphasized }
		set { visualEffectView?.isEmphasized = newValue }
	}

	override public init(
		contentRect: NSRect,
		styleMask style: NSWindow.StyleMask,
		backing backingStoreType: NSWindow.BackingStoreType = .buffered,
		defer flag: Bool
	) {
		super.init(
			contentRect: contentRect,
			styleMask: style,
			backing: backingStoreType,
			defer: flag
		)
	}

	override public var contentView: NSView? {
		get { childContentView }
		set {
			if newValue == childContentView {
				return
			}

			let bounds: NSRect = NSRect(origin: .zero, size: frame.size)

			var frameView = super.contentView
			if frameView == nil {
				frameView = NSWindow.createVisualEffectBackgroundView()
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