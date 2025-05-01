import AppLibraryResources
import SFSymbolToolbox
import SwiftUI

struct DevelopedWithLoveLink: View {
	@Environment(\.openURL) private var openURL

	public init() { }

	public var body: some View {
		Button(action: buttonAction) {
			VStack {
				Text(verbatim: text)
					.font(Self.font)
					.multilineTextAlignment(Self.multilineTextAlignment)
					.foregroundStyle(Self.textForegroundStyle)

				Image(Self.customSymbolName)
					.foregroundStyle(Self.symbolForegroundStyle)
			}
		}
		.buttonStyle(Self.buttonStyle)
	}
}

// MARK: - Constants

private extension DevelopedWithLoveLink {
	static var font: Font { .subheadline.monospaced() }
	static var textForegroundStyle: some ShapeStyle { .secondary }

	static let multilineTextAlignment: TextAlignment = .center

	static var customSymbolName: CustomSymbolName { .heart_pixel_fill }
	static var symbolForegroundStyle: some ShapeStyle { Color.developedWithLove_red }

	static var buttonStyle: some PrimitiveButtonStyle { .plain }
}

// MARK: - Properties

private extension DevelopedWithLoveLink {
	var text: String {
		let resources: [LocalizedStringResource] = [
			.developedWithLove.developer,
			.developedWithLove.location,
		]
		return resources
			.map(String.init(localized:))
			.joined(separator: "\n")
	}
}

// MARK: - Functions

private extension DevelopedWithLoveLink {
	func buttonAction() {
		openURL(.developedWithLove)
	}
}
