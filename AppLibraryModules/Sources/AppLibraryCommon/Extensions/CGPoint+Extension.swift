import struct CoreGraphics.CGPoint

public extension CGPoint {
	static func + (lhs: Self, rhs: Self) -> Self {
		Self(
			x: lhs.x + rhs.x,
			y: lhs.y + rhs.y
		)
	}

	static func += (lhs: inout Self, rhs: Self) {
		lhs = lhs + rhs
	}

	static func - (lhs: Self, rhs: Self) -> Self {
		Self(
			x: lhs.x - rhs.x,
			y: lhs.y - rhs.y
		)
	}

	static func -= (lhs: inout Self, rhs: Self) {
		lhs = lhs + rhs
	}
}