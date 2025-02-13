import SwiftUI

public struct StyledSection<Content, Header, Footer>: View where
	Content: View,
	Header: View,
	Footer: View
{
	typealias Configuration = SectionStyleConfiguration

	@Environment(\.sectionStyle) private var style

	private let content: Content
	private let header: Header
	private let footer: Footer

	/// - Parameters:
	///   - content:
	///   - header:
	///   - footer:
	public init(
		@ViewBuilder content: () -> Content,
		@ViewBuilder header: () -> Header,
		@ViewBuilder footer: () -> Footer
	) {
		self.content = content()
		self.header = header()
		self.footer = footer()
	}

	public var body: some View {
		let configuration = Configuration(
			content: content,
			header: header,
			footer: footer
		)

		style.makeBody(configuration: configuration)
	}
}

// MARK: - Convenience

public extension StyledSection {
	init<S>(
		_ title: S,
		@ViewBuilder content: () -> Content
	) where
		Header == Text,
		Footer == EmptyView,
		S: StringProtocol
	{
		self.init(content: content, header: { Text(title) }, footer: EmptyView.init)
	}

	init(
		_ titleKey: LocalizedStringKey,
		@ViewBuilder content: () -> Content
	) where
		Header == Text,
		Footer == EmptyView
	{
		self.init(content: content, header: { Text(titleKey) }, footer: EmptyView.init)
	}

	init(
		@ViewBuilder content: () -> Content
	) where
		Header == EmptyView,
		Footer == EmptyView
	{
		self.init(content: content, header: EmptyView.init, footer: EmptyView.init)
	}

	init(
		@ViewBuilder content: () -> Content,
		@ViewBuilder header: () -> Header
	) where
		Footer == EmptyView
	{
		self.init(content: content, header: header, footer: EmptyView.init)
	}

	init(
		@ViewBuilder content: () -> Content,
		@ViewBuilder footer: () -> Footer
	) where
		Header == EmptyView
	{
		self.init(content: content, header: EmptyView.init, footer: footer)
	}
}
