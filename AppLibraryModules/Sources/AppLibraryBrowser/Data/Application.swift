import Cocoa
import ExceptionCatcher

struct Application {
	let bundleIdentifier: String
	let displayName: String
	let creationDate: Date?
	let categories: [String]

	init?(metadata: NSMetadataItem) {
		guard let bundleIdentifier = try? ExceptionCatcher.catch(callback: { metadata.value(forKey: Self.bundleIdentifierKey) }) as? String else {
			return nil
		}
		guard let displayName = try? ExceptionCatcher.catch(callback: { metadata.value(forKey: Self.displayNameKey) }) as? String else {
			return nil
		}

		self.bundleIdentifier = bundleIdentifier
		self.displayName = displayName.components(separatedBy: ".").dropLast().joined(separator: ".")
		creationDate = try? ExceptionCatcher.catch(callback: { metadata.value(forKey: Self.creationDateKey) }) as? Date
		categories = (try? ExceptionCatcher.catch(callback: { metadata.value(forKey: Self.categoryKey) }) as? [String]) ?? []
	}
}

// MARK: - Identifiable

extension Application: Hashable { }

// MARK: - Identifiable

extension Application: Identifiable {
	var id: String { bundleIdentifier }
}

// MARK: - Constants

private extension Application {
	static let contentTypeKey: String = BrowserCache.contentTypeKey
	static let bundleIdentifierKey: String = NSMetadataItemCFBundleIdentifierKey
	static let displayNameKey: String = NSMetadataItemDisplayNameKey
	static let categoryKey: String = "kMDItemAppStoreCategoryType" // kMDItemApplicationCategories as String
	static let creationDateKey: String = NSMetadataItemFSCreationDateKey
//	static let copyrightKey: String = kMDItemCopyright as String
//	static let versionKey: String = kMDItemVersion as String
}
