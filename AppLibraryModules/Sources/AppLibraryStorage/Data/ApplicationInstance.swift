/*
import Foundation

public struct ApplicationInstance {
	/// The metadata this instance was generated from.
	private let metadata: NSMetadataItem

	/// The URL for an application instance is expected to be unique.
	public let url: URL

	/// If this value is `nil`, the containing ``ApplicationModel/displayName`` should be used.
	public let displayName: String?

	public let version: String?

	/// If this value is `nil`, there are no changes to the application category relative to the containing ``ApplicationModel``.
	public let applicationCategories: CollectionDifference<String>?

	public let creationDate: Date?

	public let updatedDate: Date?

	init(in application: ApplicationModel, metadata: NSMetadataItem, url: URL) {
		// Assert `url` in debug builds only.
		// This should always succeed when called correctly.
		assert((try? metadata.url) == url)

		self.metadata = metadata
		self.url = url

		// Only set `displayName` if different.
		// In most cases, `displayName` should be the same.
		displayName = Self.nilIfIdentical(originalValue: application.displayName, newValue: try? metadata.displayName)

		version = try? metadata.version

//		// Only set `applicationCategories` if different.
//		// In most cases, `applicationCategories` should be the same.
//		applicationCategories = Self.nilIfIdentical(originalValue: application.applicationCategories, newValue: try? metadata.applicationCategories)
		applicationCategories = nil

		creationDate = try? metadata.fsCreationDate
		updatedDate = try? metadata.fsContentChangeDate
	}
}

// MARK: - Identifiable

extension ApplicationInstance: Identifiable {
	// TODO: Should `id` be replaced with `ObjectIdentifier(metadata)`?
	public var id: some Hashable { url }
}

// MARK: - Convenience

extension ApplicationInstance {
	init(in application: ApplicationModel, metadata: NSMetadataItem) throws {
		try self.init(in: application, metadata: metadata, url: metadata.url)
	}
}

// MARK: - Utility

private extension ApplicationInstance {
	/// - Returns: `nil` if the `originalValue` and `newValue` are identical; the `newValue` otherwise.
	static func nilIfIdentical<T>(originalValue: borrowing T?, newValue: T?) -> T? where
		T: Equatable
	{
		if newValue != originalValue {
			newValue
		} else {
			nil
		}
	}
}
*/