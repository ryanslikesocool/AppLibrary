import Foundation

public protocol ApplicationCacheDelegate {
	/// Process query results.
	func applicationCache(processQueryResults results: [Application]) -> [Application]

	func applicationCache(didFinishQuery results: borrowing [Application])
}

// MARK: - Default Implementation

public extension ApplicationCacheDelegate {
	func applicationCache(processQueryResults results: [Application]) -> [Application] {
		results
			.standardReduction()
			.map(\.value)
			.sorted(using: .localizedStandard(\.displayName))
	}

	func applicationCache(didFinishQuery results: borrowing [Application]) { }
}