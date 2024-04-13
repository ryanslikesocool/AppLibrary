import AppLibraryCommon
import Cocoa
import ExceptionCatcher
import OSLog

public struct Application {
	private let metadata: NSMetadataItem

	public let id: ApplicationIdentifier
	public var displayName: String { id.displayName }
	public var bundleIdentifier: String { id.bundleIdentifier }

	public private(set) lazy var version: String? = try? Self.unwrap(metadata: metadata, with: Self.versionKey, as: String.self)
	public private(set) lazy var copyright: String? = try? Self.unwrap(metadata: metadata, with: Self.copyrightKey, as: String.self)
	public private(set) lazy var categories: [String]? = try? Self.unwrap(metadata: metadata, with: Self.categoryKey, as: [String].self)

	public private(set) lazy var creationDate: Date? = try? Self.unwrap(metadata: metadata, with: Self.creationDateKey, as: Date.self)
	public private(set) lazy var updatedDate: Date? = try? Self.unwrap(metadata: metadata, with: Self.updatedDateKey, as: Date.self)
//	public private(set) lazy var openedDate: Date?

	public init?(metadata: NSMetadataItem) {
		self.metadata = metadata

		let bundleIdentifier: String
		let displayName: String

		do {
			bundleIdentifier = try Self.unwrap(metadata: metadata, with: Self.bundleIdentifierKey, as: String.self)
		} catch {
			Self.logUnwrapFailure(error: error, objectDescription: "bundle identifier")
			return nil
		}

		do {
			displayName = try Self.unwrap(metadata: metadata, with: Self.displayNameKey, as: String.self)
				.components(separatedBy: ".").dropLast().joined(separator: ".")
		} catch {
			Self.logUnwrapFailure(error: error, objectDescription: "display name")
			return nil
		}

		id = ApplicationIdentifier(bundleIdentifier, named: displayName)
	}
}

// MARK: - Equatable

extension Application: Equatable { }

// MARK: - Hashable

extension Application: Hashable { }

// MARK: - Identifiable

extension Application: Identifiable { }

// MARK: - Constants

private extension Application {
	static var bundleIdentifierKey: String { NSMetadataItemCFBundleIdentifierKey }
	static var displayNameKey: String { NSMetadataItemDisplayNameKey }
	static var categoryKey: String { NSMetadataItemApplicationCategoriesKey }
	static var creationDateKey: String { NSMetadataItemFSCreationDateKey }
	static var updatedDateKey: String { NSMetadataItemFSContentChangeDateKey }
	static var copyrightKey: String { NSMetadataItemCopyrightKey }
	static var versionKey: String { NSMetadataItemVersionKey }
}

// MARK: -

private extension Application {
	static func unwrap<R>(metadata: NSMetadataItem, with key: String, as type: R.Type) throws -> R {
		let metadataValue = try ExceptionCatcher.catch(callback: { metadata.value(forKey: key) })
		guard let safeValue = metadataValue as? R else {
			throw CommonError.castFailure(from: metadataValue, to: R.self)
		}
		return safeValue
	}

	static func logUnwrapFailure(error: some Error, objectDescription: String) {
		Logger.module.error("""
		Failed to retrieve \(objectDescription) from \(NSMetadataItem.self):
		\(error.localizedDescription)
		""")
	}
}

public extension Application {
	var url: URL? {
		NSWorkspace.shared.urlForApplication(withBundleIdentifier: id.bundleIdentifier)
	}
}
