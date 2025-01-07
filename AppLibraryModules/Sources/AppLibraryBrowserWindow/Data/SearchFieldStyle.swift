import AppLibraryCommonViews

struct SearchFieldStyle {
	public let shadowA: Shadow
	public let shadowB: Shadow
	public let stroke: Stroke

	public init(shadowA: Shadow, shadowB: Shadow, stroke: Stroke) {
		self.shadowA = shadowA
		self.shadowB = shadowB
		self.stroke = stroke
	}
}
