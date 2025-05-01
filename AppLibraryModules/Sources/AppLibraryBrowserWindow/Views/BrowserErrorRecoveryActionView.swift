import AppLibraryCommon
import AppLibraryCommonViews
import AppLibrarySettingsWindow
import AppLibraryStorage
import SwiftUI

struct BrowserErrorRecoveryActionView: View {
	private let actionKind: BrowserError.RecoveryAction

	public init(error: BrowserError) {
		actionKind = error.recoveryActionKind
	}

	public var body: some View {
		switch actionKind {
			case let .openSettings(destination):
				settingsButton(destination: destination)
			case .retry:
				retryButton()
		}
	}
}

// MARK: - Supporting Views

private extension BrowserErrorRecoveryActionView {
	func settingsButton(destination: SettingsCategory) -> some View {
		SettingsButton(destination: destination)
			.controlSize(.large) // TODO: why is this large?
	}

	func retryButton() -> some View {
		RefreshButton(
			.common.action.retry,
			systemImage: .arrow_clockwise
		)
	}
}
