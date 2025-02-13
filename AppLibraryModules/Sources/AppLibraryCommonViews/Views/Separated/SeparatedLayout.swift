import SwiftUI

struct SeparatedLayout<Separator>: _VariadicView_MultiViewRoot where
	Separator: View
{
	private let includeBound: SeparatedViewBound
	private let separator: () -> Separator

	public init(
		includeBound: SeparatedViewBound,
		separator: @escaping () -> Separator
	) {
		self.includeBound = includeBound
		self.separator = separator
	}

	@ViewBuilder
	public func body(children: _VariadicView.Children) -> some View {
		let last = children.last?.id

		if includeBound.contains(.leading) {
			separator()
		}

		ForEach(children) { child in
			child

			if child.id != last {
				separator()
			}
		}

		if includeBound.contains(.trailing) {
			separator()
		}
	}
}
