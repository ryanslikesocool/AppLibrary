import Cocoa
import CoreServices
import Foundation

struct ApplicationInformation: Identifiable, Hashable {
	let bundleIdentifier: String!
	let displayName: String!
//	let category: String?
//	let copyright: String?
//	let version: String?

	var id: String { bundleIdentifier }

	init(metadata: NSMetadataItem) {
		bundleIdentifier = metadata.value(forKey: Self.bundleIdentifierKey) as? String
		displayName = metadata.value(forKey: Self.displayNameKey) as? String
//		category = metadata.value(forKey: Self.categoryKey) as? String
//		copyright = metadata.value(forKey: Self.copyrightKey) as? String
//		version = metadata.value(forKey: Self.versionKey) as? String
	}
}

extension ApplicationInformation {
	static let bundleIdentifierKey = kMDItemCFBundleIdentifier as String
	static let displayNameKey = kMDItemDisplayName as String
//	static let categoryKey = kMDItemAppStoreCategory as String
//	static let copyrightKey = kMDItemCopyright as String
//	static let versionKey = kMDItemVersion as String
}

extension ApplicationInformation {
	private static let openApplicationConfiguration: NSWorkspace.OpenConfiguration = NSWorkspace.OpenConfiguration()
	private static let genericIcon: NSImage = NSImage(named: "GenericAppIcon")!

	func getURL() -> URL? {
		NSWorkspace.shared.urlForApplication(withBundleIdentifier: bundleIdentifier)
	}

	func getBundle() -> Bundle? {
		guard let url = getURL() else {
			return nil
		}
		return Bundle(url: url)
	}

	func getBundle(url: URL) -> Bundle? {
		Bundle(url: url)
	}

	func getIcon() -> NSImage {
		guard let url = getURL() else {
			return Self.genericIcon
		}

		if let bundle = getBundle(url: url) {
			if
				let iconName = bundle.infoDictionary?["CFBundleIconName"] as? String,
				let image = bundle.image(forResource: iconName)
			{
				return image
			}

			if
				let iconFile = bundle.infoDictionary?["CFBundleIconFile"] as? String,
				let image = bundle.image(forResource: iconFile)
			{
				return image
			}

			if
				let bundleIcons = bundle.infoDictionary?["CFBundleIcons"] as? [String: Any],
				let primaryIcon = bundleIcons["CFBundlePrimaryIcon"] as? [String: Any]
			{
				if
					let iconName = primaryIcon["CFBundleIconName"] as? String,
					let image = bundle.image(forResource: iconName)
				{
					return image
				}

				if
					let files = primaryIcon["CFBundleIconFiles"] as? [String],
					let file = files.first,
					let image = bundle.image(forResource: file)
				{
					return image
				}
			}
		}

		return Self.genericIcon // NSWorkspace.shared.icon(forFile: url.path())
	}

	func open() {
		guard let url = getURL() else {
			return
		}
		NSWorkspace.shared.openApplication(at: url, configuration: Self.openApplicationConfiguration)
	}

	func showInFinder() {
		guard let url = getURL() else {
			return
		}
		NSWorkspace.shared.activateFileViewerSelecting([url])
	}

	func hide() {
		AppSettings.shared.directories.hiddenApps.insert(bundleIdentifier)
	}
}
