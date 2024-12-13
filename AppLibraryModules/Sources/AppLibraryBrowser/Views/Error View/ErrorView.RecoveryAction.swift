import AppLibraryCommon
import AppLibraryCommonViews
import AppLibrarySettingsWindow
import AppLibraryStorage
import SwiftUI

extension ErrorView {
	struct RecoveryAction: View {
		private typealias RecoveryActionKind = BrowserError?.RecoveryActionKind

		private let actionKind: RecoveryActionKind

		public init(error: BrowserError?) {
			actionKind = error.recoveryActionKind
		}

		public var body: some View {
			switch actionKind {
				case let .settings(destination):
					settingsButton(destination: destination)
				case .retry:
					retryButton()
			}
		}
	}
}

// MARK: - Supporting Views

private extension ErrorView.RecoveryAction {
	func settingsButton(destination: SettingsCategory) -> some View {
		SettingsButton(destination: destination)
			.controlSize(.large) // TODO: why is this large?
	}

	func retryButton() -> some View {
		RefreshAppsButton {
			Label {
				Text("ACTION.RETRY", table: .common)
			} icon: {
				Image(systemName: Constant.Symbol.arrow_clockwise)
			}
		}
	}
}

// MARK: -

private extension BrowserError? {
	enum RecoveryActionKind {
		case settings(SettingsCategory)
		case retry
	}

	var recoveryActionKind: RecoveryActionKind {
		switch self {
			case .noSearchScopes?: .settings(.location)
			case .noApps?: .settings(.location)
			case .allAppsHidden?: .settings(.apps)
			case .queryFailure?: .retry
			case nil: .retry
		}
	}
}
