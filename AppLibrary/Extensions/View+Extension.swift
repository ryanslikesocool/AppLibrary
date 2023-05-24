import SwiftUI

extension View {
	func shadowRcp(color: Color = Color.black, radius: Double, x: Double = 0, y: Double = 0, steps: Int = 3, base: Double = 1.0) -> some View {
		let multipliers: [Double] = (0 ..< steps).map { i in
			base / Double(i + 2)
		}

		var result: any View = self
		for i in 0 ..< steps {
			result = result.shadow(color: color.opacity(multipliers[(steps - 1) - i]), radius: radius * multipliers[i], x: x * multipliers[i], y: y * multipliers[i])
		}

		return AnyView(result)
	}
}
