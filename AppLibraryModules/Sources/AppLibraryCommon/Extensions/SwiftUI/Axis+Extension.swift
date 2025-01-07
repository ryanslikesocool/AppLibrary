import SwiftUI

public extension Axis {
	/// The perpendicular axis.
	///
	/// | Value | Perpendicular |
	/// | - | - |
	/// | ``horizontal`` | ``vertical`` |
	/// | ``vertical`` | ``horizontal`` |
	var perpendicular: Self {
		// The raw value for `Axis` works out nicely so
		// `perpendicular.rawValue == 1 - rawValue`.
		Self(rawValue: 1 - rawValue)!

		// The operation above is functionally equivalent to:
//		switch self {
//			case .horizontal: .vertical
//			case .vertical: .horizontal
//		}
	}
}
