import SwiftUI

public extension View {
	func shadow(_ shadow: borrowing Shadow) -> some View {
		self.shadow(
			color: shadow.color,
			radius: shadow.radius,
			x: shadow.x,
			y: shadow.y
		)
	}

	func overlay(
		_ stroke: borrowing Stroke,
		in shape: some InsettableShape,
		fillStyle: FillStyle = FillStyle()
	) -> some View {
		overlay(
			stroke.shapeStyle,
			in: shape
				.inset(by: stroke.strokeStyle.lineWidth * stroke.position.insetMultiplier)
				.stroke(style: stroke.strokeStyle),
			fillStyle: fillStyle
		)
	}

	func background(
		_ stroke: borrowing Stroke,
		in shape: some InsettableShape,
		fillStyle: FillStyle = FillStyle()
	) -> some View {
		background(
			stroke.shapeStyle,
			in: shape
				.inset(by: stroke.strokeStyle.lineWidth * stroke.position.insetMultiplier)
				.stroke(style: stroke.strokeStyle),
			fillStyle: fillStyle
		)
	}
}