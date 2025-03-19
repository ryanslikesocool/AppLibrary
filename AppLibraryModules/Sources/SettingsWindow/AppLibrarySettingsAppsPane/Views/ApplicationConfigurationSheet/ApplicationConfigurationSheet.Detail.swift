import AppLibraryRuntimeModel
import SwiftData
import AppLibraryStorage
import AppLibraryStorageViews
import SwiftUI

extension ApplicationConfigurationSheet {
	struct Detail: View {
		@Environment(\.modelContext) private var modelContext
		@Environment(ApplicationConfigurationSheetViewModel.self) private var viewModel

		private var applicationModel: ApplicationModel? {
			guard let selection = viewModel.selection else {
				return nil
			}
			return modelContext.registeredModel(for: selection)
		}

		public init() { }

		public var body: some View {
			if let applicationModel {
				Self.makeContent(for: applicationModel)
			} else {
				Self.makeFallbackContent()
			}
		}
	}
}

// MARK: - Supporting Views

private extension ApplicationConfigurationSheet.Detail {
	static func makeContent(for applicationModel: ApplicationModel) -> some View {
		Form {
			ApplicationVisibilityPicker(for: applicationModel)
		}
		.formStyle(.grouped)
//		.navigationTitle(
//			applicationModel?.displayName ?? ""
//		)
	}

	nonisolated static func makeFallbackContent() -> some View {
		Label(.applicationConfigurationSheet.detail.noSelection)
			.labelStyle(.emptyViewFallback)
	}
}