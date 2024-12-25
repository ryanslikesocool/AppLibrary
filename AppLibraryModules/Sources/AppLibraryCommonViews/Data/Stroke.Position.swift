import SwiftUI

public extension Stroke {
	enum Position {
		case inside
		case center
		case outside
	}
}

// MARK: - Sendable

extension Stroke.Position: Sendable { }

// MARK: - Equatable

extension Stroke.Position: Equatable { }

// MARK: - Hashable

extension Stroke.Position: Hashable { }

// MARK: -

public extension Stroke.Position {
	var insetMultiplier: CGFloat {
		switch self {
			case .inside: -0.5
			case .center: 0
			case .outside: 0.5
		}
	}
}
