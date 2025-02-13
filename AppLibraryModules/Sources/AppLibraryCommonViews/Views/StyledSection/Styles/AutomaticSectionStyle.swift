import SwiftUI

/// ## Topics
/// - ``SectionStyle/automatic``
public struct AutomaticSectionStyle: SectionStyle {
	public nonisolated init() { }

	public func makeBody(configuration: Configuration) -> some View {
		Section {
			configuration.content
		} header: {
			configuration.header
		} footer: {
			configuration.footer
		}
	}
}

// MARK: - Convenience

public extension SectionStyle where
	Self == AutomaticSectionStyle
{
	nonisolated static var automatic: Self {
		Self()
	}
}
