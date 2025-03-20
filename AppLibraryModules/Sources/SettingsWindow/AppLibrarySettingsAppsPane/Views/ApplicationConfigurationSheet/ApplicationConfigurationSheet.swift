import AppLibraryCommonViews
import AppLibraryRuntimeModel
import AppLibraryRuntimeModelViews
import AppLibraryStorage
import SwiftUI

struct ApplicationConfigurationSheet: View {
	@State private var viewModel: ApplicationConfigurationEditorViewModel = ApplicationConfigurationEditorViewModel()

	public init() { }

	public var body: some View {
		NavigationSplitView {
			Sidebar()
		} detail: {
			Detail()

				// NOTE: This modifier doesn't work when applied directly to the sidebar for some reason.
				.navigationSplitViewColumnWidth(Self.width - Self.sidebarWidth)
		}
		.toolbar {
			ToolbarItem(placement: .confirmationAction) {
				SheetDoneButton()
			}
		}
		.frame(width: Self.width, height: Self.height)
		.environment(viewModel)
	}
}

// MARK: - Constants

private extension ApplicationConfigurationSheet {
	static let width: CGFloat = 600
	static let height: CGFloat? = 350

	static let sidebarWidth: CGFloat = 230
}
