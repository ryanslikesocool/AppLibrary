import SwiftUI

public struct SheetHeaderLabel<Headline, Subheadline>: View where
	Headline: View,
	Subheadline: View
{
	private let headline: () -> Headline
	private let subheadline: () -> Subheadline

	public init(
		@ViewBuilder headline: @escaping () -> Headline,
		@ViewBuilder subheadline: @escaping () -> Subheadline
	) {
		self.headline = headline
		self.subheadline = subheadline
	}

	public var body: some View {
		LabeledContent {
			EmptyView()
		} label: {
			headline()
				.font(.headline)

			subheadline()
		}
	}
}

// MARK: - Convenience

public extension SheetHeaderLabel where
	Headline == Text,
	Subheadline == Text
{
	init<S>(
		headline: LocalizedStringResource,
		subheadline: S
	) where
		S: StringProtocol
	{
		self.init(
			headline: { Headline(headline) },
			subheadline: { Subheadline(subheadline) }
		)
	}

	init<S>(
		headline: S,
		subheadline: LocalizedStringResource
	) where
		S: StringProtocol
	{
		self.init(
			headline: { Headline(headline) },
			subheadline: { Subheadline(subheadline) }
		)
	}

	init(
		headline: LocalizedStringResource,
		subheadline: LocalizedStringResource
	) {
		self.init(
			headline: { Headline(headline) },
			subheadline: { Subheadline(subheadline) }
		)
	}
}

public extension SheetHeaderLabel {
	init(
		headline: LocalizedStringResource
	) where
		Headline == Text,
		Subheadline == EmptyView
	{
		self.init(
			headline: { Headline(headline) },
			subheadline: Subheadline.init
		)
	}
}
