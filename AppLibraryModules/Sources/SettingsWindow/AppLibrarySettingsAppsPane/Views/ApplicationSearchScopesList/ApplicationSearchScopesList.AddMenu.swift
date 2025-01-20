import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryStorage
import OSLog
import SwiftUI

extension ApplicationSearchScopesList {
	struct AddMenu: View {
		@State private var isFileImporterPresented: Bool = false

		public init() { }

		public var body: some View {
			Menu {
				Section {
					Button(
						String(localized: .applicationSearchScopesList.addMenu.action),
						action: primaryAction
					)
				}

				DefaultSearchScopesSection(addSearchScope: addSearchScope)
			} label: {
				Label(
					String(localized: .applicationSearchScopesList.addMenu.label),
					systemImage: .plus
				)
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
			.fileDialogMessage(Text(.applicationSearchScopesList.addDialog.message))
			.fileDialogConfirmationLabel(Text(.applicationSearchScopesList.addDialog.confirm))
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
				Failed to select search directory:
				- Error: \(error)
				""")
			case let .success(url):
				addSearchScope(at: url)
		}
	}

	func addSearchScope(at url: URL) {
		@Storage(apps: \.searchScopes) var searchScopes
		searchScopes.insert(url)
	}
}
