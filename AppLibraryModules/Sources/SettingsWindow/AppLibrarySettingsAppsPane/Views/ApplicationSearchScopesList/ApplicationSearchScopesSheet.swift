import AppLibraryCommonViews
import SwiftUI

struct ApplicationSearchScopesSheet: View {
	@State private var viewModel: ApplicationSearchScopesEditorViewModel = ApplicationSearchScopesEditorViewModel()

	public init() { }

	public var body: some View {
		StyledSection(
			content: makeContent,
			header: Self.makeHeader
		)
		.sectionStyle(.sheet)
		.toolbar(content: Toolbar.init)
		.frame(width: 400, height: 400)

		.deleteAction(viewModel.defaultDeleteAction)
		.modifier(ApplicationSearchScopesList.FileImporter())

		.environment(viewModel)
	}
}

// MARK: - Supporting Views

private extension ApplicationSearchScopesSheet {
	func makeContent() -> some View {
		ApplicationSearchScopesList()
			.listStyle(.inset)
	}

	@ViewBuilder
	static func makeHeader() -> some View {
		SheetHeaderLabel(
			headline: .applicationSearchScopesList.title,
			subheadline: .applicationSearchScopesList.list.description
		)

		Spacer()
	}
}
