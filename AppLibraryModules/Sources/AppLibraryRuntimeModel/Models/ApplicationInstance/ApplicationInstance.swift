import AppLibraryCommon
import AppLibraryStorage
import Foundation
import NSMetadataToolbox
import OSLog
import SwiftData

@Model
public final class ApplicationInstance {
	// VALIDATE: Can/should this be `weak`?
	@Relationship(deleteRule: .nullify)
	private(set) var applicationModel: ApplicationModel

	/// The metadata this application instance was generated from.
	@Transient
	private(set) var metadataItem: NSMetadataItem!

	// The application instance's bundle identifier.
	//
	// All ``ApplicationModel/instances`` in an `ApplicationModel` are expected to share a bundle identifier.
	//	public let bundleIdentifier: String

	/// The URL where the application instance is located.
	///
	/// All ``ApplicationModel/instances`` in an `ApplicationModel` are expected to have a unique URL.
	@Attribute(.unique, .ephemeral)
	public private(set) var url: URL

	/// The version of the application instance.
	public var version: String? {
		try? metadataItem.value(forAttribute: .version)
	}

	/// The display name for the application instance.
	///
	// If this value is `nil`, the containing ``ApplicationModel/displayName`` will be used.
	public var displayName: String? {
		try? metadataItem.value(forAttribute: .displayName)
	}

	/// The copyright for the application instance.
	///
	// If this value is `nil`, the containing ``ApplicationModel/copyright`` will be used.
	public var copyright: String? {
		try? metadataItem.value(forAttribute: .copyright)
	}

	/// The App Store category type for the application instance.
	///
	// If this value is `nil`, the containing ``ApplicationModel/appStoreCategoryType`` will be used.
	// NOTE: `.appStoreCategory` might provide a localized display name.
	public var appStoreCategoryType: AppStoreCategoryType? {
		try? metadataItem.value(forAttribute: .appStoreCategoryType.asEnum())
	}

	/// The executable architectures for the application instance.
	///
	// If this value is `nil`, the containing ``ApplicationModel/executableArchitectures`` will be used.
	public var executableArchitectures: [ExecutableArchitecture]? {
		try? metadataItem.value(forAttribute: .executableArchitectures.asEnums())
	}

	/// Alternate names for the application instance.
	///
	// If this value is `nil`, the containing ``ApplicationModel/alternateNames`` will be used.
	// In most cases, this seems to return a keyword, similar name, localized name, keyword, or the original display name with ".app" suffix.
	// This *could* be used as an additional search parameter.
//	public var alternateNames: [String]? {
//		metadataItem.value(forAttribute: .alternateNames)
//	}

	/// The file size of the application, measured in bytes.
	public var fileSize: Int64? {
		try? metadataItem.value(forAttribute: .fsSize)
	}

	/// The date the application instance was created.
	public var creationDate: Date? {
		try? metadataItem.value(forAttribute: .fsCreationDate)
	}

	/// The date the application instance was last updated.
	public var lastUpdatedDate: Date? {
		try? metadataItem.value(forAttribute: .fsContentChangeDate)
	}

	/// The date the application instance was last opened.
	public var lastOpenedDate: Date? {
		try? metadataItem.value(forAttribute: .lastUsedDate)
	}

	/// The application instance's bundle.
	public var bundle: Bundle? {
		Bundle(url: url)
	}

	/// Create an application instance.
	///
	// - Remark: This initializer only sets specific values, such as ``bundleIdentifier``, ``metadataItem``, ``url``, and ``version``.
	// Call ``resolve(in:)`` to associate the instance with an ``ApplicationModel``.
	init(applicationModel: ApplicationModel, metadataItem: NSMetadataItem) throws {
		guard
//			let bundleIdentifier = try? metadataItem.value(forAttribute: .cfBundleIdentifier),
			let url = try? metadataItem.value(forAttribute: .path.asFileURL())
		// TODO: Should we include a fallback URL?
//				?? NSWorkspace.shared.urlForApplication(withBundleIdentifier: bundleIdentifier)
		else {
			throw CommonError.unexpectedNil
		}

		self.applicationModel = applicationModel
		self.metadataItem = metadataItem
//		self.bundleIdentifier = bundleIdentifier
		self.url = url

		if FeatureFlag.Application.logInstance {
			ApplicationModel.logger.debug("""
			Found Application Instance:
			- Bundle Identifier: \(String(describing: try? metadataItem.value(forAttribute: .cfBundleIdentifier)))
			- Display Name: \(String(describing: try? metadataItem.value(forAttribute: .displayName)))
			- Path: \(String(describing: try? metadataItem.value(forAttribute: .path.asFileURL())))
			""")
		}
	}
}

// MARK: - Identifiable

// extension ApplicationInstance: Identifiable {
//	// VALIDATE: Should `id` be replaced with `ObjectIdentifier(metadata)`?
//	public var id: URL { url }
// }

// MARK: - Utility

extension ApplicationInstance {
	func formUnion(_ other: ApplicationInstance) {
		assert(other.url == url)

		// TODO: finish implementing
	}

//	/// - Returns: `nil` if the `originalValue` and `newValue` are identical; the `newValue` otherwise.
//	private static func nilIfIdentical<T>(originalValue: borrowing T?, newValue: T?) -> T? where
//		T: Equatable
//	{
//		if newValue != originalValue {
//			newValue
//		} else {
//			nil
//		}
//	}

//	mutating func resolve(in application: ApplicationModel) {
//		// Bundle identifiers must match.
//		assert(application.bundleIdentifier == metadataItem.value(forAttribute: .cfBundleIdentifier))
//
//		// Only set `displayName` if different.
//		// In most cases, `displayName` should be the same.
//		displayName = Self.nilIfIdentical(
//			originalValue: application.displayName,
//			newValue: metadataItem.value(forAttribute: .displayName)
//		)
//
//		// Only set `copyright` if different.
//		// In most cases, `copyright` should be the same.
//		copyright = Self.nilIfIdentical(
//			originalValue: application.copyright,
//			newValue: metadataItem.value(forAttribute: .copyright)
//		)
//	}
}
