import SwiftUI

struct CreditLabeledContentStyle: LabeledContentStyle {
	public init() { }

	public func makeBody(configuration: Configuration) -> some View {
		HStack {
			configuration.label
				.fontWeight(Self.labelFontWeight)

			Spacer()

			configuration.content
				.labelStyle(Self.contentLabelStyle)
		}
	}
}

// MARK: - Constants

private extension CreditLabeledContentStyle {
	static var labelFontWeight: Font.Weight { .bold }

	static var contentLabelStyle: some LabelStyle { .iconOnly }
}

// MARK: - Convenience

extension LabeledContentStyle where
	Self == CreditLabeledContentStyle
{
	static var credit: Self {
		Self()
	}
}
