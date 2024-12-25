import SwiftUI

public extension ShadowStyle {
	static func drop(_ shadow: borrowing Shadow) -> Self {
		Self.drop(color: shadow.color, radius: shadow.radius, x: shadow.x, y: shadow.y)
	}

	static func inner(_ shadow: borrowing Shadow) -> Self {
		Self.inner(color: shadow.color, radius: shadow.radius, x: shadow.x, y: shadow.y)
	}
}