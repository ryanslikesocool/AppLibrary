import SwiftUI

public struct AutomaticSectionStyle: SectionStyle {
	public init() { }

	public func makeBody(configuration: Configuration) -> some View {
		Section(
			content: { configuration.content },
			header: { configuration.header },
			footer: { configuration.footer }
		)
	}
}

// MARK: - Convenience

public extension SectionStyle where
	Self == AutomaticSectionStyle
{
	static var automatic: Self {
		Self()
	}
}