import SwiftUI

/// A wrapper that inserts dividers between elements in a view builder.
public typealias Divided<Content> = Separated<Content, Divider> where Content: View

public extension Separated where
	Separator == Divider
{
	init(@ViewBuilder content: @escaping ContentProvider) {
		self.init(content: content, separator: Divider.init)
	}
}
