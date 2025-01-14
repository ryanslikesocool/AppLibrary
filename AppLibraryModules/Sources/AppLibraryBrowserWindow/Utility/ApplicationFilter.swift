import AppLibraryRuntimeModel
import AppLibraryStorage
import Foundation

enum ApplicationFilter {
	@MainActor
	static func filter(_ applications: [ApplicationModel], searchQuery: String) -> [ApplicationModel] {
		let filterArguments = FilterArguments(
			applicationVisibilityFlags: AppsSettings.shared.applicationVisibilityFlags,
			searchQuery: searchQuery
		)
		let filterFunction = createFilterFunction(hasSearchQuery: !searchQuery.isEmpty)

		return applications.filter { application in
			filterFunction(filterArguments, application)
		}
	}
}

// MARK: -

private extension ApplicationFilter {
	@MainActor
	static func createFilterFunction(
		hasSearchQuery: Bool
	) -> (borrowing FilterArguments, borrowing ApplicationModel) -> Bool {
		if hasSearchQuery {
			{ filterArguments, application in
				let applicationIdentifier = ApplicationModelIdentifier(application)
				return filterVisibility(application, applicationVisibilityFlags: filterArguments.applicationVisibilityFlags[applicationIdentifier], visibilityFlag: .searchResults)
					&& filterDisplayName(application, searchQuery: filterArguments.searchQuery)
			}
		} else {
			{ filterArguments, application in
				let applicationIdentifier = ApplicationModelIdentifier(application)
				return filterVisibility(application, applicationVisibilityFlags: filterArguments.applicationVisibilityFlags[applicationIdentifier], visibilityFlag: .browser)
			}
		}
	}

	/// - Returns: `true` if the application should be included in the filter results; `false` otherwise.
	static func filterDisplayName(
		_ application: borrowing ApplicationModel,
		searchQuery: borrowing String
	) -> Bool {
		application.displayName.localizedStandardContains(searchQuery)
	}

	/// - Returns: `true` if the application should be included in the filter results; `false` otherwise.
	static func filterVisibility(
		_ application: borrowing ApplicationModel,
		applicationVisibilityFlags: ApplicationVisibility.Set?,
		visibilityFlag: ApplicationVisibility.Set
	) -> Bool {
		guard let applicationVisibilityFlags else {
			return true
		}
		return applicationVisibilityFlags.contains(visibilityFlag)
	}
}

// MARK: - Supporting Data

private extension ApplicationFilter {
	struct FilterArguments: ~Copyable {
		let applicationVisibilityFlags: [ApplicationModelIdentifier: ApplicationVisibility.Set]
		let searchQuery: String
	}
}
