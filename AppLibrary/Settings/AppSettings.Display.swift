import Cocoa
import Foundation

extension AppSettings {
	struct Display: Hashable {
		var appearance: Appearance

		init() {
			appearance = .system
		}
	}
}

// MARK: - Codable

extension AppSettings.Display: Codable {
	private enum CodingKeys: CodingKey {
		case appearance
	}

	init(from decoder: Decoder) throws {
		self.init()

		let container = try decoder.container(keyedBy: CodingKeys.self)

		appearance = try container.decodeIfPresent(forKey: .appearance) ?? appearance
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode(appearance, forKey: .appearance)
	}
}

// MARK: - Backing

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
