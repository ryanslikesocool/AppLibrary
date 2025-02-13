import SwiftUI

public struct SectionStyleConfiguration {
	public let content: Content
	public let header: Header?
	public let footer: Footer?

	@MainActor
	init(
		content: some View,
		header: some View,
		footer: some View
	) {
		self.content = Content(content)
		self.header = Header(header)
		self.footer = Footer(footer)
	}
}

// MARK: - Supporting Data

public extension SectionStyleConfiguration {
	/// The type-erased content of a ``StyledSection``.
	struct Content: View {
		fileprivate init<Content>(_ content: Content) where
			Content: View
		{
			body = AnyView(content)
		}

		public let body: AnyView
	}

	/// The type-erased header of a ``StyledSection``.
	struct Header: View {
		fileprivate init?<Content>(_ content: Content) where
			Content: View
		{
			guard Content.self != EmptyView.self else {
				return nil
			}
			body = AnyView(content)
		}

		public let body: AnyView
	}

	/// The type-erased footer of a ``StyledSection``.
	struct Footer: View {
		fileprivate init?<Content>(_ content: Content) where
			Content: View
		{
			guard Content.self != EmptyView.self else {
				return nil
			}
			body = AnyView(content)
		}

		public let body: AnyView
	}
}
