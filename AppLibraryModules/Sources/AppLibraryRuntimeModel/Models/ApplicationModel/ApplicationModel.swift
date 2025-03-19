import SwiftData
import AppKit
import AppLibraryCommon
import AppLibraryStorage
import Foundation
import NSMetadataToolbox
import OSLog

// TODO: The most recent version of the app should provide primary attributes.
// Primary attributes include `displayName`, `keywords`, and `appStoreCategory`.

@Model
public final class ApplicationModel {
	/// The bundle identifier for the application, usually formatted in
	/// [reverse-DNS notation]( https://en.wikipedia.org/wiki/Reverse_domain_name_notation ).
	///
	/// This value is used as the primary identifier for an application.
	/// All ``instances`` share this value.
	@Attribute(.unique)
	public private(set) var bundleIdentifier: String

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
	@Relationship(deleteRule: .cascade, minimumModelCount: 1, inverse: \ApplicationInstance.applicationModel)
	public private(set) var instances: [ApplicationInstance]

	/// The icons for the application.
//	public private(set) var icons: [NSImage]

	/// Create an application model from metadata items.
	///
	/// - Important: This initializer assumes that `bundleIdentifier` matches the value for the attribute
	/// [`NSMetadataItemCFBundleIdentifierKey`]( https://developer.apple.com/documentation/foundation/nsmetadataitemcfbundleidentifierkey )
	/// on each instance's `metadataItem`.
	internal init?<C>(bundleIdentifier: String, metadataItems: C) where
		C: Collection,
		C.Element == NSMetadataItem
	{
		// NOTE: We have to assign default values so we can use `self` when creating `instances`.

		self.displayName = String()
		self.instances = []
		self.bundleIdentifier = bundleIdentifier

		let instances = metadataItems.compactMap { metadataItem in
			try? ApplicationInstance(applicationModel: self, metadataItem: metadataItem)
		}
		guard let displayName = instances.max(using: .version)?.displayName else {
			return nil
		}
		self.displayName = Self.trimFileExtension(displayName)
		self.instances = instances
	}
}

// MARK: - ObservableObject

extension ApplicationModel: ObservableObject { }

// MARK: - Constants

extension ApplicationModel {
	private static let fileExtension: String = ".app"

	static let logger = Logger(category: ApplicationModel.self)
}

// MARK: -

public extension ApplicationModel {
	/// The configuration for the application, as defined by the user.
	@MainActor
	var configuration: ApplicationConfiguration {
		get {
			let identifier = ApplicationModelIdentifier(self)
			return AppsSettings.shared.applicationConfiguration[identifier, default: ApplicationConfiguration()]
		}
		set {
			let identifier = ApplicationModelIdentifier(self)
			AppsSettings.shared.applicationConfiguration[identifier] = newValue
		}
	}
}

// MARK: - Utility

extension ApplicationModel {
	/// - Precondition: `bundleIdentifier` and `other.bundleIdentifier` are equal.
	func formUnion(_ other: borrowing ApplicationModel) {
		assert(bundleIdentifier == other.bundleIdentifier)

		var appendingInstances: [ApplicationInstance] = []
		for newInstance in other.instances {
			if let existingInstance = self.instances.first(where: { existingInstance in
				existingInstance.url == newInstance.url
			}) {
				existingInstance.formUnion(newInstance)
			} else {
				appendingInstances.append(newInstance)
			}
		}
		instances.append(contentsOf: appendingInstances)
	}

	// VALIDATE: Do keywords need to be processed?
	// They're primarily used for search and filtering, so we could probably just do
	// `keywords.localizedStandardContains(searchQuery)`
	static func separateApplicationKeywords(_ input: borrowing String) -> Set<String> {
		guard !input.isEmpty else {
			return []
		}

		return Set(
			input
				.components(separatedBy: .punctuationCharacters)
				.map { component in
					component.trimmingCharacters(in: .whitespacesAndNewlines)
				}
		)
	}

	static func trimFileExtension(_ input: borrowing String) -> String {
		String(input.dropSuffix(fileExtension))
	}

	/// The item in ``instances`` with the greatest ``ApplicationInstance/version``.
	public var latestInstance: ApplicationInstance? {
		instances.max(using: .version)
	}
}
