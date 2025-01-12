import AppLibraryCommonViews
import SwiftUI

struct ApplicationHideFlagsSheet: View {
	public init() { }

	public var body: some View {
		StyledSection(
			content: makeContent,
			header: makeHeader,
			footer: makeFooter
		)
		.sectionStyle(.sheet)
		.frame(width: 400, height: 450)
	}
}

// MARK: - Supporting Views

private extension ApplicationHideFlagsSheet {
	func makeContent() -> some View {
//		Form {
			ApplicationHideFlagsList()
//		}
//		.formStyle(.grouped)
	}

	@ViewBuilder
	func makeHeader() -> some View {
		SheetHeaderLabel(
			headline: .applicationHideFlagsList.title,
			subheadline: LocalizedStringResource.applicationHideFlagsList.list.description
		)

		Spacer()
	}

	@ViewBuilder
	func makeFooter() -> some View {
		Spacer()

		SheetDoneButton()
	}
}
