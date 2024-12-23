import AppLibraryStorage
import Foundation

enum ApplicationFilter {
	@MainActor
	static func filter(_ applications: [ApplicationModel], searchQuery: String) -> [ApplicationModel] {
		let filterArguments = FilterArguments(
			applicationHideFlags: AppsSettings.shared.applicationHideFlags,
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
				return filterHideFlags(application, applicationHideFlags: filterArguments.applicationHideFlags[applicationIdentifier], hideFlag: .hiddenInSearch)
					&& filterDisplayName(application, searchQuery: filterArguments.searchQuery)
			}
		} else {
			{ filterArguments, application in
				let applicationIdentifier = ApplicationModelIdentifier(application)
				return filterHideFlags(application, applicationHideFlags: filterArguments.applicationHideFlags[applicationIdentifier], hideFlag: .hiddenInBrowser)
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
	static func filterHideFlags(
		_ application: borrowing ApplicationModel,
		applicationHideFlags: ApplicationHideFlag.Set?,
		hideFlag: ApplicationHideFlag.Set
	) -> Bool {
		guard let applicationHideFlags else {
			return true
		}
		return !applicationHideFlags.contains(hideFlag)
	}
}

// MARK: - Supporting Data

private extension ApplicationFilter {
	struct FilterArguments: ~Copyable {
		let applicationHideFlags: [ApplicationModelIdentifier: ApplicationHideFlag.Set]
		let searchQuery: String
	}
}