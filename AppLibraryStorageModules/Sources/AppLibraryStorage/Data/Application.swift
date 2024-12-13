import AppLibraryCommon
import Cocoa
import ExceptionCatcher
import OSLog

public struct Application {
	private let metadata: NSMetadataItem

	public let id: ApplicationIdentifier
	public let displayName: String

	public var bundleIdentifier: String { id.bundleIdentifier }
	public var version: String? { id.version }

	public private(set) lazy var copyright: String? = try? metadata.copyright
	public private(set) lazy var categories: [String]? = try? metadata.applicationCategories
	public private(set) lazy var creationDate: Date? = try? metadata.fsCreationDate
	public private(set) lazy var updatedDate: Date? = try? metadata.fsContentChangeDate
//	public private(set) lazy var openedDate: Date?

	public init?(metadata: NSMetadataItem) {
		self.metadata = metadata

		let bundleIdentifier: String
		let version: String? = try? metadata.version

		do {
			bundleIdentifier = try metadata.cfBundleIdentifier
		} catch {
			Self.logUnwrapFailure(error: error, objectDescription: "bundle identifier")
			return nil
		}

		do {
			let separator: String = "."
			displayName = try metadata.displayName
				.components(separatedBy: separator)
				.dropLast()
				.joined(separator: separator)
		} catch {
			Self.logUnwrapFailure(error: error, objectDescription: "display name")
			return nil
		}

		id = ApplicationIdentifier(bundleIdentifier, displayName: displayName, version: version)
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
	var url: URL? {
		NSWorkspace.shared.urlForApplication(withBundleIdentifier: id.bundleIdentifier)
	}

//	var urls: [URL] {
//		// NOTE: this seems to be unrelated to `urlForApplication(withBundleIdentifier:)`,
//		// and more akin to `urlsForApplications(toOpen:)`
//		NSWorkspace.shared.urlsForApplications(withBundleIdentifier: id.bundleIdentifier)
//	}
}
