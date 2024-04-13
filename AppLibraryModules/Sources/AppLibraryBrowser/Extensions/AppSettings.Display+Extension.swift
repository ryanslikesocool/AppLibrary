import AppKit
import AppLibraryStorage

extension AppSettings.Display {
	var launcherBackgroundMaterial: NSVisualEffectView.Material {
		reduceTransparency ? .windowBackground : .underWindowBackground
	}

	var willReduceMotion: Bool { NSWorkspace.shared.accessibilityDisplayShouldReduceMotion || reduceMotion }
}
