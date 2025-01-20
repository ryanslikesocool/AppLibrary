import AppLibraryStorage
import AppLibraryRuntimeModel

extension Sequence where
	Element == ApplicationModelIdentifier
{
	// ## See Also
	// - ``Sequence/filter(searchQuery:)``
	///
	/// - Parameters:
	///   - searchQuery: The string to compare application model display names against.
	/// - Returns: Application models from the ``ApplicationCache`` that match the given filter.
	@MainActor
	func filter(
		searchQuery: borrowing String
	) -> [ApplicationModel] {
		ApplicationCache.shared.values(for: self)
			.filter(searchQuery: searchQuery)
	}
}
