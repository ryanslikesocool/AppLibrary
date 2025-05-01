import AppLibraryCommonViews
import AppLibraryRuntimeModel
import AppLibraryRuntimeModelViews
import AppLibraryStorage
import NSSplitViewRepresentable
import SwiftUI

struct ApplicationConfigurationSheet: View {
	@State private var viewModel: ApplicationConfigurationEditorViewModel = ApplicationConfigurationEditorViewModel()

	public init() { }

	public var body: some View {
//		NSSplitViewRepresentable {
//			Sidebar()
//				.frame(height: Self.height)
//		} detail: {
//			Detail()
//		}
//
//		.nsSplitViewItemLayouts(Self.splitViewItemLayout)

		NavigationSplitView {
			Sidebar()
		} detail: {
			Detail()

				// NOTE: This modifier doesn't work when applied directly to the sidebar for some reason.
				.navigationSplitViewColumnWidth(Self.width - Self.sidebarWidth)
		}
		.frame(width: Self.width, height: Self.height)
		.toolbar(content: Toolbar.init)
		.environment(viewModel)
	}
}

// MARK: - Constants

private extension ApplicationConfigurationSheet {
	static let width: CGFloat = 600
	static let height: CGFloat? = 350

	static let sidebarWidth: CGFloat = 230

//	static var splitViewItemLayout: [NSSplitViewItemLayout] { [
//		.sidebar
//			.thickness(Self.sidebarWidth)
//			.collapsible(false),
//
//		.default
//			.thickness(Self.width - Self.sidebarWidth),
//	] }
}
