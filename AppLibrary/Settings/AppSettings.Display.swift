import Cocoa
import Foundation

extension AppSettings {
	struct Display: Hashable, Codable {
		var appearance: Appearance

		init() {
			appearance = .system
		}
	}
}

extension AppSettings.Display {
	enum Appearance: String, Identifiable, Codable, CustomStringConvertible {
		case system
		case light
		case dark

		var id: String { rawValue }

		var description: String { rawValue.capitalized }

		private var nativeApperance: NSAppearance? {
			switch self {
				case .system: return nil
				case .light: return NSAppearance(named: .aqua)
				case .dark: return NSAppearance(named: .darkAqua)
			}
		}

		func apply() {
			NSApplication.shared.appearance = nativeApperance
		}
	}
}
