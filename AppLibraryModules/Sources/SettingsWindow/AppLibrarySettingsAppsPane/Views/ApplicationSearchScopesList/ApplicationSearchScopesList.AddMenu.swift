import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryStorage
import OSLog
import SwiftUI

extension ApplicationSearchScopesList {
	struct AddMenu: View {
		@Environment(ApplicationSearchScopesEditorViewModel.self) private var viewModel

		public init() { }

		public var body: some View {
			Menu {
				makeMenuContent()
					.labelStyle(.automatic)
			} label: {
				Self.makeMenuLabel()
			} primaryAction: {
				primaryAction()
			}
			.fixedSize()
		}
	}
}

// MARK: - Supporting Views

private extension ApplicationSearchScopesList.AddMenu {
	@ViewBuilder
	func makeMenuContent() -> some View {
		Section {
			Button(
				LocalizedStringResource.common.link.format(.common.action.select),
				systemImage: .folder,
				action: primaryAction
			)
		}

		DefaultSearchScopesSection()
	}

	nonisolated static func makeMenuLabel() -> some View {
		Label(
			String(localized: .common.action.add),
			systemImage: .plus
		)
	}
}

// MARK: - Functions

private extension ApplicationSearchScopesList.AddMenu {
	func primaryAction() {
		viewModel.state = .fileImporter
	}
}
