import AppLibraryCommon
import Foundation

public extension ApplicationModel {
	typealias InstanceStore = OrderedDictionary<ApplicationInstance.ID, ApplicationInstance>
}

// MARK: - Convenience

extension ApplicationModel.InstanceStore {
	/// - Important: This initializer assumes that all `metadataItems` have the same value for
	/// [`NSMetadataItemCFBundleIdentifierKey`](https://developer.apple.com/documentation/foundation/nsmetadataitemcfbundleidentifierkey)\.
//	init<S>(metadataItems: borrowing S) where
//		S: Sequence,
//		S.Element == NSMetadataItem
//	{
//		let applicationInstances = metadataItems.compactMap { metadataItem in
//			try? ApplicationInstance(metadataItem: metadataItem)
//		}
//
//		self.init(instances: applicationInstances)
//	}

	/// - Important: This initializer assumes that all `instances` have the same value for
	/// [`NSMetadataItemCFBundleIdentifierKey`](https://developer.apple.com/documentation/foundation/nsmetadataitemcfbundleidentifierkey)
	/// on their `metadataItem` object.
	init<C>(bundleIdentifier: borrowing String, instances: C) where
		C: Collection,
		C.Element == ApplicationInstance
	{
		assert(instances.allBundleIdentifiersEqual(bundleIdentifier))

		self.init(uniqueKeysWithValues:
			instances
				.map { application in
					(application.id, application)
				}
		)
		sort()
	}
}

// MARK: -

public extension ApplicationModel.InstanceStore {
	/// Sort the dictionary using the default sort comparator.
	mutating func sort() {
		sort(by: \.version, comparator: .localizedStandard)
	}
}
