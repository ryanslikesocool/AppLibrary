import SwiftUI

extension View {
	func betterShadow(color: Color = Color.black, radius: CGFloat, x: CGFloat = 0, y: CGFloat = 0) -> some View {
		let offsetSteps: [Double] = [
			0.2,
			0.3,
			0.5,
		]
		let opacitySteps: [Double] = [
			0.5,
			0.3,
			0.2,
		]
		let radiusSteps: [Double] = [
			0.2,
			0.3,
			0.5,
		]

		return shadow(color: color.opacity(opacitySteps[0]), radius: radius * radiusSteps[0], x: x * offsetSteps[0], y: y * offsetSteps[0])
			.shadow(color: color.opacity(opacitySteps[1]), radius: radius * radiusSteps[1], x: x * offsetSteps[1], y: y * offsetSteps[1])
			.shadow(color: color.opacity(opacitySteps[2]), radius: radius * radiusSteps[2], x: x * offsetSteps[2], y: y * offsetSteps[2])
	}
}
