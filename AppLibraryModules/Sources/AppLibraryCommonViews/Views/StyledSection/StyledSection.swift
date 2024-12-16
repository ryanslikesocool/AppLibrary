import SwiftUI

public struct StyledSection<Content, Header, Footer>: View where
	Content: View,
	Header: View,
	Footer: View
{
	typealias Configuration = SectionStyleConfiguration

	@Environment(\.sectionStyle) private var style

	private let content: () -> Content
	private let header: () -> Header
	private let footer: () -> Footer

	public init(
		@ViewBuilder content: @escaping () -> Content,
		@ViewBuilder header: @escaping () -> Header,
		@ViewBuilder footer: @escaping () -> Footer
	) {
		self.content = content
		self.header = header
		self.footer = footer
	}

	public var body: some View {
		style.makeBody(configuration: SectionStyleConfiguration(
			content: content,
			header: header,
			footer: footer
		))
	}
}

// MARK: - Convenience

public extension StyledSection {
	init<S>(_ title: S, @ViewBuilder content: @escaping () -> Content) where
		Header == Text,
		Footer == EmptyView,
		S: StringProtocol
	{
		self.init(content: content, header: { Text(title) }, footer: EmptyView.init)
	}

	init(_ titleKey: LocalizedStringKey, @ViewBuilder content: @escaping () -> Content) where
		Header == Text,
		Footer == EmptyView
	{
		self.init(content: content, header: { Text(titleKey) }, footer: EmptyView.init)
	}

	init(@ViewBuilder content: @escaping () -> Content) where
		Header == EmptyView,
		Footer == EmptyView
	{
		self.init(content: content, header: EmptyView.init, footer: EmptyView.init)
	}

	init(@ViewBuilder content: @escaping () -> Content, @ViewBuilder header: @escaping () -> Header) where
		Footer == EmptyView
	{
		self.init(content: content, header: header, footer: EmptyView.init)
	}

	init(@ViewBuilder content: @escaping () -> Content, @ViewBuilder footer: @escaping () -> Footer) where
		Header == EmptyView
	{
		self.init(content: content, header: EmptyView.init, footer: footer)
	}
}
