import Cocoa

enum TileUtilities {
	static func listAllApplications(scopes: [URL], onComplete: @escaping ([NSMetadataItem]) -> Void) {
		let query: NSMetadataQuery = NSMetadataQuery()
		query.searchScopes = scopes
		let pred: NSPredicate = NSPredicate(format: "kMDItemContentType == 'com.apple.application-bundle'")

		NotificationCenter.default.addObserver(forName: .NSMetadataQueryDidFinishGathering, object: nil, queue: .main, using: recieve)

		query.predicate = pred
		query.start()

		func recieve(notification: Notification) {
			NotificationCenter.default.removeObserver(recieve, name: .NSMetadataQueryDidFinishGathering, object: nil)
			let metadata = query.results.compactMap { $0 as? NSMetadataItem }
			onComplete(metadata)
		}
	}
}
