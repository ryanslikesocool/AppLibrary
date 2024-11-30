import AppLibraryCommon
import Cocoa

extension Constant {
	enum Application {
		static let bundleIdentifierKey: String = NSMetadataItemCFBundleIdentifierKey
		static let displayNameKey: String = NSMetadataItemDisplayNameKey
		static let categoryKey: String = NSMetadataItemApplicationCategoriesKey
		static let creationDateKey: String = NSMetadataItemFSCreationDateKey
		static let updatedDateKey: String = NSMetadataItemFSContentChangeDateKey
		static let copyrightKey: String = NSMetadataItemCopyrightKey
		static let versionKey: String = NSMetadataItemVersionKey
	}
}
