import SwiftUI

public extension Axis {
	var perpendicular: Self {
		Self(rawValue: 1 - rawValue)!
	}
}