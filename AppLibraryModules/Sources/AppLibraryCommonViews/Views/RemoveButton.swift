import AppLibraryCommon
import SwiftUI

public struct RemoveButton<Label>: View where
	Label: View
{
	private let role: ButtonRole?
	private let action: @MainActor () -> Void
	private let label: Label

	public init(
		role: ButtonRole? = .destructive,
		action: @escaping @MainActor () -> Void,
		@ViewBuilder label: () -> Label
	) {
		self.role = role
		self.action = action
		self.label = label()
	}

	public var body: some View {
		Button(
			role: role,
			action: action
		) {
			label
		}
	}
}

// MARK: - Convenience

public extension RemoveButton where
	Label == SwiftUI.Label<Text, Image>
{
	init(
		role: ButtonRole? = .destructive,
		action: @escaping @MainActor () -> Void
	) {
		self.init(
			role: role,
			action: action
		) {
			Label(
				String(localized: .common.action.remove),
				systemImage: .trash
			)
		}
	}
}
