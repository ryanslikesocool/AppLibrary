import AppLibraryCommon
import AppLibraryCommonViews
import AppLibrarySettingsViews
import AppLibraryStorage
import OSLog
import SwiftUI

struct ErrorView: View {
	private let error: BrowserError?

	public init(reason error: BrowserError?) {
		self.error = error
	}

	public var body: some View {
		VStack {
			Image(systemName: Constant.Symbol.exclamationMark_octagon)
				.resizable()
				.fontWeight(.semibold)
				.frame(width: 48, height: 48)
				.padding(.horizontal, 32)

			ErrorTitle(error: error)
			RecoverySuggestion(error: error)
			RecoveryAction(error: error)
		}
		.multilineTextAlignment(.center)
		.foregroundStyle(.secondary)
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.padding()
	}
}
