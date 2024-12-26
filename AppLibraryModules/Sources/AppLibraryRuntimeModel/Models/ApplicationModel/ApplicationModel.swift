import AppKit
import AppLibraryCommon
import Foundation
import NSMetadataToolbox

public final class ApplicationModel {
	/// The bundle identifier for the application, usually formatted in
	/// [reverse-DNS notation](https://en.wikipedia.org/wiki/Reverse_domain_name_notation)\.
	///
	/// This value is used as the primary identifier for an application.
	/// All ``instances`` share this value.
	public let bundleIdentifier: String

	/// The display name for the application.
	///
	/// Individual ``instances`` may override this value.
	/// The default value is provided by the instance with the newest ``ApplicationInstance/version``.
	public private(set) var displayName: String

	/// The copyright string for the application.
	///
	/// Individual ``instances`` may override this value.
	/// The default value is provided by the instance with the newest ``ApplicationInstance/version``.
	public var copyright: String? {
		instances.lazy.compactMap(\.copyright).last
	}

	/// The keywords for the application.
	///
	/// Individual ``instances`` may override this value.
	/// The default value is provided by the instance with the newest ``ApplicationInstance/version``.
//	public private(set) var keywords: Set<String>?

	/// The App Store category type for the application.
	///
	/// Individual ``instances`` may override this value.
	/// The default value is provided by the instance with the newest ``ApplicationInstance/version``.
//	public private(set) var appStoreCategoryType: AppStoreCategoryType?

	/// The instances of this application.
	public private(set) var instances: InstanceStore

	/// The icons for the application.
//	public private(set) var icons: [NSImage]

	/// Create an application model from metadata items.
	///
	/// - Important: This initializer assumes that `bundleIdentifier` matches the value for the attribute
	/// [`NSMetadataItemCFBundleIdentifierKey`](https://developer.apple.com/documentation/foundation/nsmetadataitemcfbundleidentifierkey)
	/// on all `metadataItems`.
//	public init?<S>(bundleIdentifier: String, metadataItems: borrowing S) where
//		S: Sequence,
//		S.Element == NSMetadataItem
//	{
//		instances = InstanceStore(metadataItems: metadataItems)
//
//		guard let displayName = instances.lazy.compactMap(\.displayName).last else {
//			return nil
//		}
//
//		self.bundleIdentifier = bundleIdentifier
//		self.displayName = Self.trimFileExtension(displayName)
//	}

	/// Create an application model from application instances.
	///
	/// - Important: This initializer assumes that `bundleIdentifier` matches the value for the attribute
	/// [`NSMetadataItemCFBundleIdentifierKey`](https://developer.apple.com/documentation/foundation/nsmetadataitemcfbundleidentifierkey)
	/// on each instance's `metadataItem`.
	public init?<C>(bundleIdentifier: String, instances: C) where
		C: Collection,
		C.Element == ApplicationInstance
	{
		self.instances = InstanceStore(bundleIdentifier: bundleIdentifier, instances: instances)

		guard let displayName = instances.lazy.compactMap(\.displayName).last else {
			return nil
		}

		self.bundleIdentifier = bundleIdentifier
		self.displayName = Self.trimFileExtension(displayName)
	}
}

// MARK: - ObservableObject

extension ApplicationModel: ObservableObject { }

// MARK: -

extension ApplicationModel {
	// TODO: The most recent version of the app should provide primary attributes.
	// Primary attributes include `displayName`, `keywords`, and `appStoreCategory`.
}

// MARK: - Utility

extension ApplicationModel {
	/// - Precondition: `bundleIdentifier` and `other.bundleIdentifier` are equal.
	func formUnion(_ other: ApplicationModel) {
		assert(bundleIdentifier == other.bundleIdentifier)

		instances.merge(other.instances) { _, newValue in
			// TODO: merge `oldValue` and `newValue`
			newValue
		}
		instances.sort()
	}

	// TODO: Do keywords need to be processed?
	// They're primarily used for search and filtering, so we could probably just do
	// `keywords.localizedStandardContains(searchQuery)`
	static func separateApplicationKeywords(_ input: String?) -> Set<String>? {
		guard
			let input,
			!input.isEmpty
		else {
			return nil
		}

		return Set(
			input
				.components(separatedBy: .punctuationCharacters)
				.map { component in
					component.trimmingCharacters(in: .whitespacesAndNewlines)
				}
		)
	}

	static func trimFileExtension(_ input: String) -> String {
		String(input.dropSuffix(".app"))
	}

	static func trimFileExtension(_ input: String?) -> String? {
		guard
			let input,
			!input.isEmpty
		else {
			return nil
		}
		return trimFileExtension(input)
	}

	/// The item in ``instances`` with the highest ``ApplicationInstance/version``.
	public var latestInstance: ApplicationInstance? {
		instances.last
	}
}
