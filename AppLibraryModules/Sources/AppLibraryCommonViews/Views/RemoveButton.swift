import AppLibraryCommon
import SwiftUI

public struct RemoveButton<Label>: View where
	Label: View
{
	private let label: Label
	private let action: @MainActor () -> Void

	public init(
		action: @escaping @MainActor () -> Void,
		@ViewBuilder label: () -> Label
	) {
		self.action = action
		self.label = label()
	}

	public var body: some View {
		Button(action: action) {
			label
		}
	}
}

// MARK: - Convenience

public extension RemoveButton where
	Label == SwiftUI.Label<Text, Image>
{
	init(
		action: @escaping @MainActor () -> Void
	) {
		self.init(action: action) {
			Label(
				String(localized: .common.action.remove),
				systemImage: .trash
			)
		}
	}
}
