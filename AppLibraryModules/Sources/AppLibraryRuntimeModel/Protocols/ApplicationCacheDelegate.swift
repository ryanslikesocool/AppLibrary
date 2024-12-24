import AppLibraryCommon
import AppLibraryStorage
import Foundation

public protocol ApplicationCacheDelegate {
	/// Process query results.
	func applicationCache(processQueryResults results: [ApplicationModel]) -> OrderedDictionary<ApplicationModelIdentifier, ApplicationModel>

	func applicationCache(didFinishQuery results: borrowing OrderedDictionary<ApplicationModelIdentifier, ApplicationModel>)
}

// MARK: - Default Implementation

public extension ApplicationCacheDelegate {
	func applicationCache(processQueryResults results: [ApplicationModel]) -> OrderedDictionary<ApplicationModelIdentifier, ApplicationModel> {
		OrderedDictionary(
			results.map { element in (ApplicationModelIdentifier(element), element) }
		) { oldValue, newValue in
			oldValue.formUnion(newValue)
			return oldValue
		}
		.sorted(by: \.displayName, comparator: .localizedStandard)
	}

	func applicationCache(didFinishQuery results: borrowing OrderedDictionary<ApplicationModelIdentifier, ApplicationModel>) { }
}
