import AppLibraryCommonViews
import AppLibraryRuntimeModel
import AppLibraryRuntimeModelViews
import AppLibraryStorage
import SwiftUI

struct ApplicationConfigurationSheet: View {
	@State private var searchQuery: String = ""
	@State private var selection: ApplicationModelIdentifier? = nil

	public init() { }

	public var body: some View {
		StyledSection(
			content: makeContent,
			footer: makeFooter
		)
		.sectionStyle(.sheet)
		.frame(width: Self.width, height: Self.height)

		.searchable(text: $searchQuery, placement: .sidebar)
	}
}

// MARK: - Constants

private extension ApplicationConfigurationSheet {
	static let width: CGFloat? = 600
	static let height: CGFloat? = 450

	static let sidebarWidth: CGFloat = 200
}

// MARK: - Supporting Views

private extension ApplicationConfigurationSheet {
	func makeContent() -> some View {
		NavigationSplitView {
			Sidebar(selection: $selection, searchQuery: $searchQuery)
				.navigationSplitViewColumnWidth(Self.sidebarWidth)
		} detail: {
			if let selection {
				Form {
					Detail(for: selection)
				}
				.formStyle(.grouped)
			} else {
				Label(.applicationConfigurationSheet.detail.noSelection)
					.labelStyle(.emptyViewFallback)
			}
		}
	}

	@ViewBuilder
	func makeFooter() -> some View {
		Spacer()

		SheetDoneButton()
	}
}
