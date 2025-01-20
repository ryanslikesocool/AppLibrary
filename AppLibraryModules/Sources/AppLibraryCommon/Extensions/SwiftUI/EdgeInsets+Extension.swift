import SwiftUI

public extension EdgeInsets {
	init(
		horizontal: CGFloat = .zero,
		vertical: CGFloat = .zero
	) {
		self.init(
			top: vertical,
			leading: horizontal,
			bottom: vertical,
			trailing: horizontal
		)
	}
}