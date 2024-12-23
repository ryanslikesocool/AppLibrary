import SwiftUI

public struct Stroke {
	public let position: Stroke.Position
	public let shapeStyle: AnyShapeStyle
	public let strokeStyle: StrokeStyle

	public init(
		position: Stroke.Position = .center,
		shapeStyle: AnyShapeStyle,
		strokeStyle: StrokeStyle
	) {
		self.position = position
		self.shapeStyle = shapeStyle
		self.strokeStyle = strokeStyle
	}
}

// MARK: - Convenience

public extension Stroke {
	init(
		position: Stroke.Position = .center,
		shapeStyle: some ShapeStyle,
		strokeStyle: StrokeStyle
	) {
		self.init(
			position: position,
			shapeStyle: AnyShapeStyle(shapeStyle),
			strokeStyle: strokeStyle
		)
	}

	init(
		position: Stroke.Position = .center,
		shapeStyle: AnyShapeStyle,
		lineWidth: CGFloat
	) {
		self.init(
			position: position,
			shapeStyle: shapeStyle,
			strokeStyle: StrokeStyle(lineWidth: lineWidth)
		)
	}

	init(
		position: Stroke.Position = .center,
		shapeStyle: some ShapeStyle,
		lineWidth: CGFloat
	) {
		self.init(
			position: position,
			shapeStyle: shapeStyle,
			strokeStyle: StrokeStyle(lineWidth: lineWidth)
		)
	}
}
