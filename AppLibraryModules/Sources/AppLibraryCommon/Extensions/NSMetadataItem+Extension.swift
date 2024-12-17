import ExceptionCatcher
import Foundation

public extension NSMetadataItem {
	subscript<Key>(key: Key.Type) -> Key.Value where
		Key: NSMetadataItemKey
	{
		get throws {
			let metadataValue = try ExceptionCatcher.catch {
				self.value(forKey: Key.key)
			}

			guard let safeValue = metadataValue as? Key.Value else {
				throw CommonError.castFailure(from: metadataValue, to: Key.Value.self)
			}
			return safeValue
		}
	}
}

// MARK: - NSMetadataItemKey

public extension NSMetadataItem {
	// MARK: cfBundleIdentifier

	var cfBundleIdentifier: String {
		get throws {
			try self[__Key_cfBundleIdentifier.self]
		}
	}

	private enum __Key_cfBundleIdentifier: NSMetadataItemKey {
		public typealias Value = String

		public static let key: String = NSMetadataItemCFBundleIdentifierKey
	}

	// MARK: displayName

	var displayName: String {
		get throws {
			try self[__Key_displayName.self]
		}
	}

	private enum __Key_displayName: NSMetadataItemKey {
		public typealias Value = String

		public static let key: String = NSMetadataItemDisplayNameKey
	}

	// MARK: applicationCategories

	var applicationCategories: [String] {
		get throws {
			try self[__Key_applicationCategories.self]
		}
	}

	private enum __Key_applicationCategories: NSMetadataItemKey {
		public typealias Value = [String]

		public static let key: String = NSMetadataItemApplicationCategoriesKey
	}

	// MARK: fsCreationDate

	var fsCreationDate: Date {
		get throws {
			try self[__Key_fsCreationDate.self]
		}
	}

	private enum __Key_fsCreationDate: NSMetadataItemKey {
		public typealias Value = Date

		public static let key: String = NSMetadataItemFSCreationDateKey
	}

	// MARK: fsContentChangeDate

	var fsContentChangeDate: Date {
		get throws {
			try self[__Key_fsContentChangeDate.self]
		}
	}

	private enum __Key_fsContentChangeDate: NSMetadataItemKey {
		public typealias Value = Date

		public static let key: String = NSMetadataItemFSContentChangeDateKey
	}

	// MARK: copyright

	var copyright: String {
		get throws {
			try self[__Key_copyright.self]
		}
	}

	private enum __Key_copyright: NSMetadataItemKey {
		public typealias Value = String

		public static let key: String = NSMetadataItemCopyrightKey
	}

	// MARK: version

	var version: String {
		get throws {
			try self[__Key_version.self]
		}
	}

	private enum __Key_version: NSMetadataItemKey {
		public typealias Value = String

		public static let key: String = NSMetadataItemVersionKey
	}

	// MARK: url

	var url: URL {
		get throws {
			try self[__Key_url.self]
		}
	}

	private enum __Key_url: NSMetadataItemKey {
		public typealias Value = URL

		public static let key: String = NSMetadataItemURLKey
	}
}
