import AppKit

public enum Appearance: UInt8, Hashable, Codable, CaseIterable {
	case system
	case light
	case dark
}

// MARK: - Identifiable

extension Appearance: Identifiable {
	public var id: UInt8 { rawValue }
}

// MARK: - CustomStringConvertible

extension Appearance: CustomStringConvertible {
	public var description: String {
		switch self {
			case .system: "System"
			case .light: "Light"
			case .dark: "Dark"
		}
	}
}

// MARK: - Supporting

extension Appearance {
	var nsApperance: NSAppearance? {
		switch self {
			case .system: nil
			case .light: NSAppearance(named: .aqua)
			case .dark: NSAppearance(named: .darkAqua)
		}
	}
}
