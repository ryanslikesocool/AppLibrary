import AppKit

// @frozen
enum KeyState {
	case down
	case up
}

// MARK: - RawRepresentable

extension KeyState: RawRepresentable {
	public typealias RawValue = Bool

	public init(rawValue: RawValue) {
		self = switch rawValue {
			case true: .down
			case false: .up
		}
	}

	public var rawValue: Bool {
		switch self {
			case .down: true
			case .up: false
		}
	}
}

// MARK: - Sendable

extension KeyState: Sendable { }

// MARK: - Equatable

extension KeyState: Equatable { }

// MARK: - Hashable

extension KeyState: Hashable { }

// MARK: - Identifiable

extension KeyState: Identifiable {
	public var id: RawValue { rawValue }
}

// MARK: - CaseIterable

extension KeyState: CaseIterable { }

// MARK: - Convenience

extension KeyState {
	public init?(_ eventType: NSEvent.EventType) {
		switch eventType {
			case .keyDown: self = .down
			case .keyUp: self = .up
			default: return nil
		}
	}
}