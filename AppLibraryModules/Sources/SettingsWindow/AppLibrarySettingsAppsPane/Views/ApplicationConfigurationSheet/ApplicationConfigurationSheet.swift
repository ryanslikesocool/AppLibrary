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
				.navigationSplitViewColumnWidth(Self.sidebarWidth)
				.navigationDestination(for: ApplicationModelIdentifier.self) { applicationModelIdentifier in
					Detail(for: applicationModelIdentifier)
				}
		} detail: {
			Label(.applicationConfigurationSheet.detail.noSelection)
				.labelStyle(.emptyViewFallback)
		}
		.toolbar {
			ToolbarItem(placement: .cancellationAction) {
				SheetDoneButton()
			}
		}
		.frame(width: Self.width, height: Self.height)
	}
}

// MARK: - Constants

private extension ApplicationConfigurationSheet {
	static let width: CGFloat? = 600
	static let height: CGFloat? = 350

	static let sidebarWidth: CGFloat = 200
}
