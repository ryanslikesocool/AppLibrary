import SwiftUI

public struct SectionStyleConfiguration {
	public let content: ContentView?
	public let header: HeaderView?
	public let footer: FooterView?

	@MainActor
	init<Content, Header, Footer>(
		content: Content,
		header: Header,
		footer: Footer
	) where
		Content: View,
		Header: View,
		Footer: View
	{
		self.content = if Content.self == EmptyView.self {
			nil
		} else {
			ContentView(content)
		}
		self.header = if Header.self == EmptyView.self {
			nil
		} else {
			HeaderView(header)
		}
		self.footer = if Footer.self == EmptyView.self {
			nil
		} else {
			FooterView(footer)
		}
	}
}

// MARK: - Supporting Data

public extension SectionStyleConfiguration {
	struct ContentView: View {
		fileprivate init(_ content: some View) {
			body = AnyView(content)
		}

		public let body: AnyView
	}

	struct HeaderView: View {
		fileprivate init(_ content: some View) {
			body = AnyView(content)
		}

		public let body: AnyView
	}

	struct FooterView: View {
		fileprivate init(_ content: some View) {
			body = AnyView(content)
		}

		public let body: AnyView
	}
}
