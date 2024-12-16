import LocalizationTable
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

public extension SheetHeaderLabel {
	init(
		headline headlineKey: LocalizedStringKey,
		subheadline subheadlineKey: LocalizedStringKey,
		table: LocalizationTableResource
	) where
		Headline == Text,
		Subheadline == Text
	{
		self.init(
			headline: { Text(headlineKey, table: table) },
			subheadline: { Text(subheadlineKey, table: table) }
		)
	}

	init(
		headline headlineKey: LocalizedStringKey,
		table: LocalizationTableResource
	) where
		Headline == Text,
		Subheadline == EmptyView
	{
		self.init(
			headline: { Text(headlineKey, table: table) },
			subheadline: EmptyView.init
		)
	}
}
