import AppLibraryCommon
import Cocoa
import ExceptionCatcher
import OSLog

public struct Application {
	private let metadata: NSMetadataItem

	public let id: ApplicationIdentifier

	public var bundleIdentifier: String { id.bundleIdentifier }
	public var version: String? { id.version }

	public let url: URL
	public let displayName: String

	// TODO: `lazy` properties on structs are causing some headaches...

	public private(set) lazy var copyright: String? = try? metadata.copyright
	public private(set) lazy var categories: [String]? = try? metadata.applicationCategories
	public private(set) lazy var creationDate: Date? = try? metadata.fsCreationDate
	public private(set) lazy var updatedDate: Date? = try? metadata.fsContentChangeDate
//	public private(set) lazy var openedDate: Date?

	public init(metadata: NSMetadataItem) throws {
		self.metadata = metadata

		let bundleIdentifier: String = try metadata.cfBundleIdentifier
		let version: String? = try? metadata.version

		url = try metadata.url

		let separator: String = "."
		displayName = try metadata.displayName
			.components(separatedBy: separator)
			.dropLast()
			.joined(separator: separator)

		id = ApplicationIdentifier(bundleIdentifier, version: version, displayName: displayName)
	}
}

// MARK: - Equatable

extension Application: Equatable { }

// MARK: - Hashable

extension Application: Hashable { }

// MARK: - Identifiable

extension Application: Identifiable { }

// MARK: -

private extension Application {
	static func logUnwrapFailure(error: some Error, objectDescription: String) {
		Logger.module.error("""
		Failed to retrieve \(objectDescription) from \(NSMetadataItem.self):
		\(error.localizedDescription)
		""")
	}
}

public extension Application {
//	var urls: [URL] {
//		// NOTE: this seems to be unrelated to `urlForApplication(withBundleIdentifier:)`,
//		// and more akin to `urlsForApplications(toOpen:)`
//		NSWorkspace.shared.urlsForApplications(withBundleIdentifier: id.bundleIdentifier)
//	}
}
