import AppKit

public enum Appearance: UInt8 {
	case system
	case light
	case dark
}

// MARK: - Sendable

extension Appearance: Sendable { }

// MARK: - Equatable

extension Appearance: Equatable { }

// MARK: - Hashable

extension Appearance: Hashable { }

// MARK: - Codable

extension Appearance: Codable { }

// MARK: - Identifiable

extension Appearance: Identifiable {
	public var id: RawValue { rawValue }
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

// MARK: - CaseIterable

extension Appearance: CaseIterable { }

// MARK: -

public extension Appearance {
	var nsApperance: NSAppearance? {
		switch self {
			case .system: nil
			case .light: NSAppearance(named: .aqua)
			case .dark: NSAppearance(named: .darkAqua)
		}
	}
}
