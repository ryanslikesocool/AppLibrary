import AppKit

public enum Appearance: String, Hashable, Codable, CaseIterable, Sendable {
	case system
	case light
	case dark
}

// MARK: - Identifiable

extension Appearance: Identifiable {
	public var id: String { rawValue }
}

// MARK: - CustomStringConvertible

extension Appearance: CustomStringConvertible {
	public var description: String { rawValue.capitalized }
}

// MARK: -

extension Appearance {
	var nsApperance: NSAppearance? {
		switch self {
			case .system: nil
			case .light: NSAppearance(named: .aqua)
			case .dark: NSAppearance(named: .darkAqua)
		}
	}
}
