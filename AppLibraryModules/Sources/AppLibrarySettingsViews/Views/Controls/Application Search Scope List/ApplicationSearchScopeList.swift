import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryStorage
import OSLog
import SwiftUI

struct ApplicationSearchScopeList: View {
	@Storage(locations: \.self) private var locations
	@Storage(locations: \.searchScopes) private var searchScopes
	@State private var showDirectoryPicker: Bool = false

	public init() { }

	public var body: some View {
		Section {
			if searchScopes.isEmpty {
				emptyListLabel
			} else {
				listContent
			}
		} header: {
			sectionHeader
		} footer: {
			sectionFooter
		}

		.fileImporter(
			isPresented: $showDirectoryPicker,
			allowedContentTypes: [.folder],
			onCompletion: completeFileImporter
		)
		.fileDialogDefaultDirectory(.homeDirectory)
		.fileDialogMessage("Add a Search Scope")
		.fileDialogConfirmationLabel("Select Scope")

		.onChange(of: searchScopes) { Event.refreshApps.send() }
	}
}

// MARK: - Supporting Views

private extension ApplicationSearchScopeList {
	var emptyListLabel: some View {
		Text("No search scopes...")
			.foregroundStyle(.secondary)
	}

	var listContent: some View {
		let searchScopes = searchScopes
			.sorted(using: URL.PathComparator())

		return ForEach(searchScopes, id: \.self) { item in
			Item(
				for: item,
				onRemove: { locations.removeSearchScope(at: item) }
			)
		}
	}

	@ViewBuilder
	var sectionHeader: some View {
		Text("Search Scopes")
		Text("The Library will look for apps in these directories.")
	}

	var sectionFooter: some View {
		Menu("Add Scope", systemImage: Constant.Symbol.plus) {
			Section {
				Button("Add Custom Scope") { showDirectoryPicker = true }
			}
			Section("Default Scopes") {
				let defaultSearchScopes = Constant.Settings.defaultSearchScopes
					.sorted(using: URL.PathComparator())
					.map(Identifier.init(wrappedValue:))

				ForEach(defaultSearchScopes) { url in
					let url = url.wrappedValue

					Button(url.abbreviatingWithTildeInPath) { locations.addSearchScope(at: url) }
						.disabled(searchScopes.contains(url))
				}
			}
		} primaryAction: {
			showDirectoryPicker = true
		}
		.labelStyle(.iconOnly)
		.fixedSize()
	}
}

// MARK: - Functions

private extension ApplicationSearchScopeList {
	func completeFileImporter(_ result: Result<URL, Error>) {
		switch result {
			case let .failure(error):
				Logger.module.error("""
				Failed to select new search directory.
				- Error: \(error)
				""")
			case let .success(url):
				locations.addSearchScope(at: url)
		}
	}
}
