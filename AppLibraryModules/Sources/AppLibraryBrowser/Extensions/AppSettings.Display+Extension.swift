import AppKit
import SwiftUI
import AppLibraryStorage

extension AppSettings.Display {
	var launcherBackgroundMaterial: NSVisualEffectView.Material {
		reduceTransparency ? .windowBackground : .underWindowBackground
	}
	var searchBackgroundMaterial: AnyShapeStyle {
		reduceTransparency ? AnyShapeStyle(.background) : AnyShapeStyle(.regularMaterial)
	}

	var willReduceMotion: Bool { NSWorkspace.shared.accessibilityDisplayShouldReduceMotion || reduceMotion }
}
