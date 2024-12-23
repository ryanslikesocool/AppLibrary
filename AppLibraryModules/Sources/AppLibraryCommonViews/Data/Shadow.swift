import SwiftUI

public struct Shadow {
	public let color: Color
	public let radius: CGFloat
	public let x: CGFloat
	public let y: CGFloat

	public init(
		color: Color,
		radius: CGFloat,
		x: CGFloat = CGFloat.zero,
		y: CGFloat = CGFloat.zero
	) {
		self.color = color
		self.radius = radius
		self.x = x
		self.y = y
	}
}

// MARK: - Sendable

extension Shadow: Sendable { }

// MARK: - Equatable

extension Shadow: Equatable { }

// MARK: - Hashable

extension Shadow: Hashable { }

// MARK: - Convenience

public extension Shadow {
	init(
		opacity: Double,
		radius: CGFloat,
		x: CGFloat = .zero,
		y: CGFloat = .zero
	) {
		self.init(
			color: Color(.sRGBLinear, white: 0, opacity: opacity),
			radius: radius,
			x: x,
			y: y
		)
	}

	static func drop(
		color: Color = Color(.sRGBLinear, white: 0, opacity: 0.33),
		radius: CGFloat,
		x: CGFloat = .zero,
		y: CGFloat = .zero
	) -> Self {
		Self(
			color: color,
			radius: radius,
			x: x,
			y: y
		)
	}

	static func inner(
		color: Color = Color(.sRGBLinear, white: 0, opacity: 0.55),
		radius: CGFloat,
		x: CGFloat = .zero,
		y: CGFloat = .zero
	) -> Self {
		Self(
			color: color,
			radius: radius,
			x: x,
			y: y
		)
	}
}
