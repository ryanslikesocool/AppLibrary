import AppLibraryRuntimeModel
import AppLibraryStorage
import Foundation

extension Sequence where
	Element == ApplicationModel
{
	// ## See Also
	// - ``Sequence/filter(searchQuery:)``
	///
	/// - Parameters:
	///   - searchQuery: The string to compare application model display names against.
	/// - Returns: Application models that match the given filter.
	@MainActor
	func filter(searchQuery: String) -> [Element] {
		let filterArguments = ApplicationFilterArguments(
			searchQuery: searchQuery
		)

		let filterFunction = ApplicationModel.createFilterFunction(filterArguments: filterArguments)

		return filter { application in
			filterFunction(filterArguments, application)
		}
	}
}

// MARK: -

private extension ApplicationModel {
	/// Create the primary function used to filter application models.
	@MainActor
	static func createFilterFunction(
		filterArguments: borrowing ApplicationFilterArguments
	) -> (borrowing ApplicationFilterArguments, ApplicationModel) -> Bool {
		return if filterArguments.searchQuery.isEmpty {
			{ filterArguments, application in
				application.visibilityFlags.contains(.browser)
			}
		} else {
			{ filterArguments, application in
				application.visibilityFlags.contains(.searchResults)
					&& application.displayName.localizedStandardContains(filterArguments.searchQuery)
			}
		}
	}
}

// MARK: - Supporting Data

private struct ApplicationFilterArguments: ~Copyable {
	public let searchQuery: String

	public init(
		searchQuery: String
	) {
		self.searchQuery = searchQuery
	}
}
