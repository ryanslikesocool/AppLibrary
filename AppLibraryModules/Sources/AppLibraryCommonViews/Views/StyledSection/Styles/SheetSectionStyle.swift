import SwiftUI

public struct SheetSectionStyle: SectionStyle {
	public init() { }

	public func makeBody(configuration: Configuration) -> some View {
		VStack(spacing: .zero) {
			if let header = configuration.header {
				HStack {
					header
				}
				.padding()
				.frame(maxWidth: .infinity)

				Divider()
			}

			configuration.content

			if let footer = configuration.footer {
				Divider()

				HStack {
					footer
				}
				.padding()
				.frame(maxWidth: .infinity)
			}
		}
		.sectionStyle(.automatic)
	}
}

// MARK: - Convenience

public extension SectionStyle where
	Self == SheetSectionStyle
{
	static var sheet: Self {
		Self()
	}
}
