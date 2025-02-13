import SwiftUI

/// A wrapper that inserts spacers between elements in a view builder.
public typealias Spaced<Content> = Separated<Content, Spacer> where Content: View

public extension Separated where
	Separator == Spacer
{
	init(
		minLength: CGFloat? = nil,
		@ViewBuilder content: @escaping () -> Content
	) {
		self.init(content: content, separator: { Spacer(minLength: minLength) })
	}
}
