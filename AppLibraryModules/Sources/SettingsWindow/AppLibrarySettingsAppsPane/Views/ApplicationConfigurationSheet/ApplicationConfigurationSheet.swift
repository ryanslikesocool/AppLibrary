import AppLibraryCommonViews
import AppLibraryRuntimeModel
import AppLibraryRuntimeModelViews
import AppLibraryStorage
import SwiftUI

struct ApplicationConfigurationSheet: View {
	public init() { }

	public var body: some View {
		NavigationSplitView {
			Sidebar()
				.navigationDestination(for: ApplicationModelIdentifier.self) { applicationModelIdentifier in
					Detail(for: applicationModelIdentifier)
				}
		} detail: {
			Label(.applicationConfigurationSheet.detail.noSelection)
				.labelStyle(.emptyViewFallback)

				// NOTE: This modifier doesn't work when applied directly to the sidebar for some reason.
				.navigationSplitViewColumnWidth(Self.width - Self.sidebarWidth)
		}
		.toolbar {
			ToolbarItem(placement: .confirmationAction) {
				SheetDoneButton()
			}
		}
		.frame(width: Self.width, height: Self.height)
	}
}

// MARK: - Constants

private extension ApplicationConfigurationSheet {
	static let width: CGFloat = 600
	static let height: CGFloat? = 350

	static let sidebarWidth: CGFloat = 230
}
