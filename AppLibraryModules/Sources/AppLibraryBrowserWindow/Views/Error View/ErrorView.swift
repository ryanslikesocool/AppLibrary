import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryStorage
import OSLog
import SwiftUI

struct ErrorView: View {
	private let error: BrowserError

	public init(reason error: BrowserError) {
		self.error = error
	}

	public var body: some View {
		VStack {
			Image(systemName: .exclamationMark_octagon)
				.resizable()
				.fontWeight(Self.iconFontWeight)
				.frame(width: Self.iconWidth, height: Self.iconHeight)
				.padding(.horizontal, Self.iconHorizontalPadding)

			ErrorTitle(error: error)
			RecoverySuggestion(error: error)
			RecoveryAction(error: error)
		}
		.multilineTextAlignment(Self.multilineTextAlignment)
		.foregroundStyle(Self.foregroundStyle)
		.frame(maxWidth: Self.maxWidth, maxHeight: Self.maxHeight)
		.padding()
	}
}

// MARK: - Constants

private extension ErrorView {
	static var iconFontWeight: Font.Weight { .semibold }

	static let iconWidth: CGFloat? = 48
	static var iconHeight: CGFloat? { iconWidth }

	static let iconHorizontalPadding: CGFloat = 32

	static let multilineTextAlignment: TextAlignment = .center
	static var foregroundStyle: some ShapeStyle { .secondary }

	static var maxWidth: CGFloat? { .infinity }
	static var maxHeight: CGFloat? { .infinity }
}
