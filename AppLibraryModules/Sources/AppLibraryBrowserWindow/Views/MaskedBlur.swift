import SwiftUI

struct MaskedBlur: View {
	private let style: AnyShapeStyle
	private let mask: AnyView

	public init(
		style: some ShapeStyle,
		@ViewBuilder mask: () -> some View
	) {
		self.style = AnyShapeStyle(style)
		self.mask = AnyView(mask())
	}

	public var body: some View {
		Rectangle()
			.foregroundStyle(style)
			.mask { mask }
	}
}

// MARK: - Convenience

extension MaskedBlur {
	public init(
		style: some ShapeStyle,
		opacity: ClosedRange<Double> = 0.0 ... 1.0,
		stepLocation: CGFloat,
		startPoint: UnitPoint = .top,
		endPoint: UnitPoint = .bottom
	) {
		self.init(
			style: style
		) {
			let gradientStops: [Gradient.Stop] = [
				Gradient.Stop(color: Color.white.opacity(opacity.upperBound), location: 0),
				Gradient.Stop(color: Color.white.opacity(opacity.upperBound), location: stepLocation),
				Gradient.Stop(color: Color.white.opacity(opacity.lowerBound), location: 1),
			]
			LinearGradient(stops: gradientStops, startPoint: startPoint, endPoint: endPoint)
		}
	}
}
