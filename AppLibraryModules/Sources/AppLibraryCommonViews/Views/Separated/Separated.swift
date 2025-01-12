import SwiftUI

/// A wrapper that inserts separators between elements in a view builder.
///
/// Based on [this approach](https://movingparts.io/variadic-views-in-swiftui#writing-our-own-container-view) by Moving Parts.
public struct Separated<Content, Separator>: View where
	Content: View,
	Separator: View
{
	public typealias ContentProvider = () -> Content
	public typealias SeparatorProvider = () -> Separator

	private let includeBound: SeparatedViewBound
	private let content: ContentProvider
	private let separator: SeparatorProvider

	public init(
		includeBound: SeparatedViewBound = .none,
		@ViewBuilder content: @escaping ContentProvider,
		@ViewBuilder separator: @escaping SeparatorProvider
	) {
		self.includeBound = includeBound
		self.content = content
		self.separator = separator
	}

	public var body: some View {
		let layout = SeparatedLayout(
			includeBound: includeBound,
			separator: separator
		)

		_VariadicView.Tree(layout, content: content)
	}
}
