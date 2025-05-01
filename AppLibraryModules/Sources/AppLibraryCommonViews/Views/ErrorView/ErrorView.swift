import SwiftUI

public struct ErrorView<Title, Icon, RecoverySuggestion, RecoveryAction>: View where
	Title: View,
	Icon: View,
	RecoverySuggestion: View,
	RecoveryAction: View
{
	typealias Configuration = ErrorViewStyleConfiguration

	@Environment(\.errorViewStyle) private var style

	private let configuration: Configuration

	public init(
		@ViewBuilder title: () -> Title,
		@ViewBuilder icon: () -> Icon,
		@ViewBuilder recoverySuggestion: () -> RecoverySuggestion,
		@ViewBuilder recoveryAction: () -> RecoveryAction,
	) {
		configuration = Configuration(
			title: title(),
			icon: icon(),
			recoverySuggestion: recoverySuggestion(),
			recoveryAction: recoveryAction(),
		)
	}

	public var body: some View {
		style.makeBody(configuration: configuration)
	}
}

// MARK: - Convenience

public extension ErrorView {
	init?(
		reason error: some LocalizedError,
	) where
		Title == Text,
		Icon == Image,
		RecoverySuggestion == Text?,
		RecoveryAction == EmptyView
	{
		guard let errorDescription = error.errorDescription else {
			return nil
		}

		self.init(
			title: { Title(verbatim: errorDescription) },
			icon: {
				Icon(systemName: .exclamationMark_octagon)
					.resizable()
			},
			recoverySuggestion: { Text(verbatim: error.recoverySuggestion) },
			recoveryAction: RecoveryAction.init
		)
	}
}
