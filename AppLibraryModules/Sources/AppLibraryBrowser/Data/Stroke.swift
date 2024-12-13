import SwiftUI

struct Stroke {
	public let style: AnyShapeStyle
	public let width: Double

	public init(style: some ShapeStyle, width: Double) {
		self.style = AnyShapeStyle(style)
		self.width = width
	}
}