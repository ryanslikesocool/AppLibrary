import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryStorage
import OSLog
import SwiftUI

extension ApplicationSearchScopeList {
	struct AddMenu: View {
		@Storage(locations: \.self) private var locations

		@State private var isFileImporterPresented: Bool = false

		public init() { }

		public var body: some View {
			Menu {
				Section {
					Button(action: primaryAction) {
						Text("ADD_MENU.ACTION", table: .applicationSearchScopeList)
					}
				}

				DefaultSearchScopesSection(addSearchScope: addSearchScope)
			} label: {
				Label {
					Text("ADD_MENU.LABEL", table: .applicationSearchScopeList)
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
			.fileDialogMessage(Text("ADD_SCOPE_DIALOG.MESSAGE", table: .applicationSearchScopeList))
			.fileDialogConfirmationLabel(Text("ADD_SCOPE_DIALOG.CONFIRM", table: .applicationSearchScopeList))
		}
	}
}

// MARK: - Functions

private extension ApplicationSearchScopeList.AddMenu {
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
