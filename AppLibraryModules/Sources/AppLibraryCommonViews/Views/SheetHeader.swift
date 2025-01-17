import SwiftUI

public struct SheetHeaderLabel<Headline, Subheadline>: View where
	Headline: View,
	Subheadline: View
{
	private let headline: () -> Headline
	private let subheadline: () -> Subheadline

	/// - Parameters:
	///   - headline:
	///   - subheadline:
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
	/// - Parameters:
	///   - headline:
	///   - subheadline:
	init<S>(
		headline: LocalizedStringResource,
		subheadline: S
	) where
		S: StringProtocol
	{
		self.init(
			headline: { Text(headline) },
			subheadline: { Text(subheadline) }
		)
	}

	/// - Parameters:
	///   - headline:
	///   - subheadline:
	init<S>(
		headline: S,
		subheadline: LocalizedStringResource
	) where
		S: StringProtocol
	{
		self.init(
			headline: { Text(headline) },
			subheadline: { Text(subheadline) }
		)
	}

	/// - Parameters:
	///   - headline:
	///   - subheadline:
	init(
		headline: LocalizedStringResource,
		subheadline: LocalizedStringResource
	) {
		self.init(
			headline: { Text(headline) },
			subheadline: { Text(subheadline) }
		)
	}
}

public extension SheetHeaderLabel {
	/// - Parameters:
	///   - headline:
	init(
		headline: LocalizedStringResource
	) where
		Headline == Text,
		Subheadline == EmptyView
	{
		self.init(
			headline: { Text(headline) },
			subheadline: EmptyView.init
		)
	}
}
