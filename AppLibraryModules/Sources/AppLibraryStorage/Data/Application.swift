import AppKit
import AppLibraryCommon
import MetadataQueryToolbox
import OSLog

public struct Application {
	private let metadata: NSMetadataItem

	public let id: ApplicationIdentifier

	public init(metadata: NSMetadataItem) throws {
		self.metadata = metadata

		guard
			let bundleIdentifier = metadata.value(forAttribute: \.cfBundleIdentifier),
			var displayName = metadata.value(forAttribute: \.displayName)
		else {
			throw CommonError.unexpectedNil
		}

		if displayName.hasSuffix(".app") {
			let separationCharacter: String = "."
			displayName = displayName
				.components(separatedBy: separationCharacter)
				.dropLast()
				.joined(separator: separationCharacter)
		}

		id = ApplicationIdentifier(bundleIdentifier, displayName: displayName)
	}
}

// MARK: - Equatable

extension Application: Equatable { }

// MARK: - Hashable

extension Application: Hashable { }

// MARK: - Identifiable

extension Application: Identifiable { }

// MARK: - Properties

public extension Application {
	// Is `NSMetadataItem` performant enough to allow us
	// to just use computed properties?

	var bundleIdentifier: String {
		id.bundleIdentifier
	}

	var displayName: String {
		id.displayName
	}

	var url: URL? {
		if let path = metadata.value(forAttribute: \.path) {
			URL(filePath: path, directoryHint: .notDirectory)
		} else {
			// fallback
			NSWorkspace.shared.urlForApplication(withBundleIdentifier: bundleIdentifier)
		}
	}

	var copyright: String? {
		metadata.value(forAttribute: \.copyright)
	}

	var version: String? {
		metadata.value(forAttribute: \.version)
	}

	var creationDate: Date? {
		metadata.value(forAttribute: \.fsCreationDate)
	}

	var updatedDate: Date? {
		metadata.value(forAttribute: \.fsContentChangeDate)
	}

	var lastOpenedDate: Date? {
		metadata.value(forAttribute: \.lastUsedDate)
	}

	/// The file size of the application, measured in bytes.
	var fileSize: Int64? {
		metadata.value(forAttribute: \.fsSize)
	}

	var fileSizeDescription: String? {
		fileSize?.formatted(.byteCount(style: .file))
	}

	// NOTE: \.appStoreCategory *might* provide a localized display name
	var appStoreCategory: AppStoreCategory? {
		if let appStoreCategoryType = metadata.value(forAttribute: \.appStoreCategoryType) {
			AppStoreCategory(rawValue: appStoreCategoryType)
		} else {
			nil
		}
	}

	var executableArchitectures: [ExecutableArchitecture]? {
		metadata.value(forAttribute: \.executableArchitectures)?
			.compactMap(ExecutableArchitecture.init(rawValue:))
	}

	var keywords: String? {
		metadata.value(forAttribute: \.keywords)
	}

	// TODO: Do keywords need to be processed?
	// They're primarily used for search and filtering, so we could probably just do
	// `keywords.localizedStandardContains(searchQuery)`
//	var processedKeywords: [String] {
//		keywords?
//			.replaceEmptyWithNil?
//			.components(separatedBy: .punctuationCharacters)
//			.map { component in
//				component.trimmingCharacters(in: .whitespacesAndNewlines)
//			}
//	}

	// In most cases, this seems to return a keyword, similar name, localized name, keyword, or the original display name with ".app" suffix.
	// This *could* be used as an additional search parameter.
	var alternateNames: [String]? {
		metadata.value(forAttribute: \.alternateNames)
	}
}
