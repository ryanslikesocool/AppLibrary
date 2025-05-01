import AppLibraryCommonViews
import AppLibraryResources
import SwiftUI

extension ErrorView {
	init?(reason error: BrowserError) where
		Title == Text,
		Icon == Image,
		RecoverySuggestion == Text,
		RecoveryAction == BrowserErrorRecoveryActionView
	{
		guard
			let errorDescription = error.errorDescription,
			let recoverySuggestion = error.recoverySuggestion
		else {
			return nil
		}

		self.init(
			title: { Title(errorDescription) },
			icon: {
				Icon(systemName: .exclamationMark_octagon)
					.resizable()
			},
			recoverySuggestion: { RecoverySuggestion(recoverySuggestion) },
			recoveryAction: { RecoveryAction(error: error) }
		)
	}
}
