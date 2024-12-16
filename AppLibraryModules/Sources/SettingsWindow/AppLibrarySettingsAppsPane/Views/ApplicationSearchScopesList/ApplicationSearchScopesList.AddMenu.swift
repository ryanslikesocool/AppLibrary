import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryStorage
import OSLog
import SwiftUI

extension ApplicationSearchScopesList {
	struct AddMenu: View {
		@Storage(locations: \.self) private var locations

		@State private var isFileImporterPresented: Bool = false

		public init() { }

		public var body: some View {
			Menu {
				Section {
					Button(action: primaryAction) {
						Text("ADD_MENU.ACTION", table: .applicationSearchScopesList)
					}
				}

				DefaultSearchScopesSection(addSearchScope: addSearchScope)
			} label: {
				Label {
					Text("ADD_MENU.LABEL", table: .applicationSearchScopesList)
				} icon: {
					Image(systemName: Constant.Symbol.plus)
				}
			} primaryAction: {
				primaryAction()
			}
			.labelStyle(.iconOnly)
			.fixedSize()

			.fileImporter(
				isPresented: $isFileImporterPresented,
				allowedContentTypes: [.folder],
				onCompletion: onFileImporterCompleted
			)
			.fileDialogDefaultDirectory(.homeDirectory)
			.fileDialogMessage(Text("ADD_SCOPE_DIALOG.MESSAGE", table: .applicationSearchScopesList))
			.fileDialogConfirmationLabel(Text("ADD_SCOPE_DIALOG.CONFIRM", table: .applicationSearchScopesList))
		}
	}
}

// MARK: - Functions

private extension ApplicationSearchScopesList.AddMenu {
	func primaryAction() {
		isFileImporterPresented = true
	}

	func onFileImporterCompleted(_ result: Result<URL, Error>) {
		switch result {
			case let .failure(error):
				Logger.module.error("""
				Failed to select new search directory.
				- Error: \(error)
				""")
			case let .success(url):
				addSearchScope(at: url)
		}
	}

	func addSearchScope(at url: URL) {
		locations.addSearchScope(at: url)
	}
}
