import SwiftUI

public struct SheetDoneButton<Label>: View where
	Label: View
{
	@Environment(\.dismiss) private var dismiss
	private let label: Label

	public init(
		@ViewBuilder label: () -> Label
	) {
		self.label = label()
	}

	public var body: some View {
		Button {
			dismiss()
		} label: {
			label
		}
	}
}

// MARK: - Convenience

public extension SheetDoneButton where
	Label == SwiftUI.Text
{
	init() {
		self.init {
			Label(.common.action.done)
		}
	}
}
