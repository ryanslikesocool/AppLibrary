import AppLibraryStorage
import OSLog
import SwiftUI

extension ApplicationSearchScopesList {
	struct FileImporter: ViewModifier {
		@Environment(ApplicationSearchScopesEditorViewModel.self) private var viewModel

		public init() { }

		public func body(content: Content) -> some View {
			let isPresented = makeIsPresentedBinding()

			content
				.background {
					EmptyView()
						.fileImporter(
							isPresented: isPresented,
							allowedContentTypes: [.folder],
							onCompletion: onFileImporterCompleted
						)
						.fileDialogDefaultDirectory(.homeDirectory)
						.fileDialogMessage(Text(.applicationSearchScopesList.addDialog.message))
						.fileDialogConfirmationLabel(Text(.applicationSearchScopesList.addDialog.confirm))
				}
		}
	}
}

// MARK: - Functions

private extension ApplicationSearchScopesList.FileImporter {
	func makeIsPresentedBinding() -> Binding<Bool> {
		@Bindable var viewModel = viewModel
		return $viewModel.state[.fileImporter]
	}

	func onFileImporterCompleted(_ result: Result<URL, Error>) {
		switch result {
			case let .failure(error):
				Logger.module.error("""
				Failed to select search directory:
				- Error: \(error)
				""")
			case let .success(url):
				viewModel.addSearchScope(url)
		}
	}
}
