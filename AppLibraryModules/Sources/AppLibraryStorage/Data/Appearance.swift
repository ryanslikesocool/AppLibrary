import AppKit

public enum Appearance: String {
	case light
	case dark
}

// MARK: - Hashable

extension Appearance: Hashable { }

// MARK: - Identifiable

extension Appearance: Identifiable {
	public var id: RawValue { rawValue }
}

// MARK: - Codable

extension Appearance: Codable { }

// MARK: -

public extension Appearance? {
	func apply() {
		NSApp.appearance = switch self {
			case .light: NSAppearance(named: .aqua)
			case .dark: NSAppearance(named: .darkAqua)
			default: nil
		}
	}
}
