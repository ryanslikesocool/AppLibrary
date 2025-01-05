import SwiftUI

public extension ShadowStyle {
	/// Creates a custom drop shadow style.
	///
	/// - Parameter shadow: The shadow style parameters.
	static func drop(_ shadow: borrowing Shadow) -> Self {
		Self.drop(color: shadow.color, radius: shadow.radius, x: shadow.x, y: shadow.y)
	}

	/// Creates a custom inner shadow style.
	///
	/// - Parameter shadow: The shadow style parameters.
	static func inner(_ shadow: borrowing Shadow) -> Self {
		Self.inner(color: shadow.color, radius: shadow.radius, x: shadow.x, y: shadow.y)
	}
}
