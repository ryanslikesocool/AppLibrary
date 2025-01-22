public extension Comparable {
	func clamped(
		to bounds: borrowing ClosedRange<Self>
	) -> Self {
		max(
			min(
				self,
				bounds.upperBound
			),
			bounds.lowerBound
		)
	}
}