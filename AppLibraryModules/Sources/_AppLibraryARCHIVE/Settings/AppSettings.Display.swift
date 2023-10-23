import Cocoa

extension AppSettings {
	struct Display: Hashable {
		var appearance: Appearance
		var activeInDock: Bool

		init() {
			appearance = .system
			activeInDock = false
		}

		func apply() {
			appearance.apply()
			NSApp.setActivationPolicy(activeInDock ? .regular : .accessory)
		}
	}
}

// MARK: - Codable

extension AppSettings.Display: Codable {
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		let dflt: Self = Self()

		appearance = try container.decodeIfPresent(Appearance.self, forKey: .appearance) ?? dflt.appearance
		activeInDock = try container.decodeIfPresent(Bool.self, forKey: .activeInDock) ?? dflt.activeInDock
	}
}

// MARK: - Backing

extension AppSettings.Display {
	enum Appearance: String, Hashable, Identifiable, Codable, CustomStringConvertible {
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
