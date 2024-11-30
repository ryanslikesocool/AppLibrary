import AppKit

public enum Appearance: String {
	case light
	case dark
}

// MARK: - Sendable

extension Appearance: Sendable { }

// MARK: - Equatable

extension Appearance: Equatable { }

// MARK: - Hashable

extension Appearance: Hashable { }

// MARK: - Identifiable

extension Appearance: Identifiable {
	public var id: RawValue { rawValue }
}

// MARK: - Codable

extension Appearance: Codable { }

// MARK: -

public extension Optional<Appearance> {
	@MainActor
	func apply() {
		NSApplication.shared.appearance = switch self {
			case .light: NSAppearance(named: .aqua)
			case .dark: NSAppearance(named: .darkAqua)
			default: nil
		}
	}
}
