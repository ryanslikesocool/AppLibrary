import AppLibraryCommonViews
import SwiftUI

struct ApplicationSearchScopesSheet: View {
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

private extension ApplicationSearchScopesSheet {
	func makeContent() -> some View {
		Form {
			ApplicationSearchScopesList()
		}
		.formStyle(.grouped)
	}

	@ViewBuilder
	func makeHeader() -> some View {
		SheetHeaderLabel(
			headline: .applicationSearchScopesList.title,
			subheadline: .applicationSearchScopesList.list.description
		)

		Spacer()

		ApplicationSearchScopesList.AddMenu()
	}

	@ViewBuilder
	func makeFooter() -> some View {
		Spacer()

		SheetDoneButton()
	}
}
