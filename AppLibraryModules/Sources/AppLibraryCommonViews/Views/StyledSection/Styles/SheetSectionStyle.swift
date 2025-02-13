import SwiftUI

/// ## Topics
/// - ``SectionStyle/sheet``
public struct SheetSectionStyle: SectionStyle {
	public nonisolated init() { }

	public func makeBody(configuration: Configuration) -> some View {
		VStack(spacing: .zero) {
			Divided {
				Self.unwrapBar(configuration.header)
				configuration.content
				Self.unwrapBar(configuration.footer)
			}
		}
		.sectionStyle(.automatic)
	}
}

// MARK: - Supporting Views

private extension SheetSectionStyle {
	@ViewBuilder
	static func unwrapBar(_ content: (some View)?) -> some View {
		if let content {
			HStack {
				content
			}
			.padding()
			.frame(maxWidth: .infinity)
		}
	}
}

// MARK: - Convenience

public extension SectionStyle where
	Self == SheetSectionStyle
{
	nonisolated static var sheet: Self {
		Self()
	}
}
