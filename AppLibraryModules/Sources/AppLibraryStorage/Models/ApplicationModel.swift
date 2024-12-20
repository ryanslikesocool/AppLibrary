/*
import Foundation

public final class ApplicationModel {
	/// The bundle identifier for the application, usually formatted in [reverse-DNS notation](https://en.wikipedia.org/wiki/Reverse_domain_name_notation).
	public let bundleIdentifier: String

	/// The display name for the application.
	///
	/// Individual ``instances`` may override this value when displayed.
	public let displayName: String

	/// The keywords for the application.
	///
	/// This value created from the unique keywords of all ``instances``.
	public private(set) var keywords: Set<String>?

	public private(set) var appStoreCategory: AppStoreCategory?

	/// The instances of this application that can be found.
	// TODO: Should `instances` be an array?  A dictionary keyed by ``ApplicationInstance/id``?
	public private(set) var instances: [ApplicationInstance]

	/// The icons for the application.
	public private(set) var icons: [NSImage]

	public init(bundleIdentifier: String, displayName: String, keywords: String?, appStoreCategory: AppStoreCategory?) {
		self.bundleIdentifier = bundleIdentifier
		self.displayName = displayName
		self.keywords = keywords
		self.appStoreCategory = appStoreCategory
		instances = []
	}
}

// MARK: -

extension ApplicationModel {
	// TODO: The most recent version of the app should provide the primary attribute.
	// Primary attributes include `displayName`, `keywords`, and `appStoreCategory`.

//	func insertInstance(withMetadata metadataItem: NSMetadataItem) throws {
//		let newInstance = try ApplicationInstance(in: self, metadata: metadataItem)
//		instances.append(newInstance)
//
//		if let newApplicationCategories = try? metadataItem.applicationCategories {
//			applicationCategories
//		}
//	}

	func insertInstances(withMetadata metadataItems: [NSMetadataItem]) {
		updateInstances()
		updateApplicationCategories()

		func updateInstances() {
			// Lazy filter.  I should probably reimplement this.
			// Only elements that do not exist in ``instances`` will be used.
			// Only the first element in `metadataItems` for a specific `url` will be used.
			let newMetadataItems = metadataItems.reduce(into: [URL: NSMetadataItem]()) { partialResult, element in
				guard
					let url = try? element.url,
					!partialResult.keys.contains(url),
					!instances.contains(where: { instance in instance.url == url })
				else {
					return
				}
				partialResult[url] = element
			}

			let newInstances = newMetadataItems.map { (url, metadataItem) in
				ApplicationInstance(in: self, metadata: metadataItem, url: url)
			}

//			self.instances.applying(<#T##difference: CollectionDifference<ApplicationInstance>##CollectionDifference<ApplicationInstance>#>)
			self.instances.append(contentsOf: newInstances)
		}

		func updateApplicationCategories() {
			let newApplicationCategories = metadataItems.compactMap { metadataItem in
				try? metadataItem.applicationCategories
			}
		}
	}
}
*/
