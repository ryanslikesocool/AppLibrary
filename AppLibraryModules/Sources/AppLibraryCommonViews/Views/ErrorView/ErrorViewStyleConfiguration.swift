import SwiftUI

public struct ErrorViewStyleConfiguration {
	/// The type-erased title of an ``ErrorView``.
	public let title: Title

	/// The type-erased icon of an ``ErrorView``.
	public let icon: Icon?

	/// The type-erased recovery suggestion of an ``ErrorView``.
	public let recoverySuggestion: RecoverySuggestion?

	/// The type-erased recovery action of an ``ErrorView``.
	public let recoveryAction: RecoveryAction?

	@MainActor
	init(
		title: some View,
		icon: some View,
		recoverySuggestion: some View,
		recoveryAction: some View,
	) {
		self.title = Title(title)
		self.icon = Icon(icon)
		self.recoverySuggestion = RecoverySuggestion(recoverySuggestion)
		self.recoveryAction = RecoveryAction(recoveryAction)
	}
}

// MARK: - Supporting Data

public extension ErrorViewStyleConfiguration {
	/// The type-erased title of an ``ErrorView``.
	struct Title: View {
		fileprivate init<Content>(_ content: Content) where
			Content: View
		{
			body = AnyView(content)
		}

		public let body: AnyView
	}

	/// The type-erased icon of an ``ErrorView``.
	struct Icon: View {
		fileprivate init?<Content>(_ content: Content) where
			Content: View
		{
			guard Content.self != EmptyView.self else {
				return nil
			}
			body = AnyView(content)
		}

		public let body: AnyView
	}

	/// The type-erased recovery suggestion of an ``ErrorView``.
	struct RecoverySuggestion: View {
		fileprivate init?<Content>(_ content: Content) where
			Content: View
		{
			guard Content.self != EmptyView.self else {
				return nil
			}
			body = AnyView(content)
		}

		public let body: AnyView
	}

	/// The type-erased recovery action of an ``ErrorView``.
	struct RecoveryAction: View {
		fileprivate init?<Content>(_ content: Content) where
			Content: View
		{
			guard Content.self != EmptyView.self else {
				return nil
			}
			body = AnyView(content)
		}

		public let body: AnyView
	}
}
