import AppKit
import AppLibraryStorage

extension Application {
	//	func getBundle() -> Bundle? {
	//		guard let url else {
	//			return nil
	//		}
	//		return Bundle(url: url)
	//	}
	//
	//	func getBundle(url: URL) -> Bundle? {
	//		Bundle(url: url)
	//	}

	func getIcon() -> NSImage {
		lazy var genericIcon: NSImage = NSWorkspace.shared.icon(for: .applicationPlaceholder)

		guard
			let url,
			let bundle = Bundle(url: url),
			let infoDictionary = bundle.infoDictionary
		else {
			// NSWorkspace.shared.icon(forFile: url.path())
			return genericIcon
		}

		// there's gotta be a better way to do this...

		return try_CFBundleIconName()
			?? try_CFBundleIconFile()
			?? try_CFBundleIcons_CFBundlePrimaryIcon_CFBundleIconName()
			?? try_CFBundleIcons_CFBundlePrimaryIcon_CFBundleIconFiles()
			?? genericIcon // fallback

		func try_CFBundleIconName() -> NSImage? {
			guard
				let value = infoDictionary["CFBundleIconName"] as? String,
				let image = bundle.image(forResource: value)
			else {
				return nil
			}
			return image
		}

		func try_CFBundleIconFile() -> NSImage? {
			guard
				let value = infoDictionary["CFBundleIconFile"] as? String,
				let image = bundle.image(forResource: value)
			else {
				return nil
			}
			return image
		}

		func try_CFBundleIcons_CFBundlePrimaryIcon_CFBundleIconName() -> NSImage? {
			guard
				let bundleIcons = infoDictionary["CFBundleIcons"] as? [String: Any],
				let primaryIcon = bundleIcons["CFBundlePrimaryIcon"] as? [String: Any],
				let iconName = primaryIcon["CFBundleIconName"] as? String,
				let image = bundle.image(forResource: iconName)
			else {
				return nil
			}
			return image
		}

		func try_CFBundleIcons_CFBundlePrimaryIcon_CFBundleIconFiles() -> NSImage? {
			guard
				let bundleIcons = bundle.object(forInfoDictionaryKey: "CFBundleIcons") as? [String: Any],
				let primaryIcon = bundleIcons["CFBundlePrimaryIcon"] as? [String: Any],
				let files = primaryIcon["CFBundleIconFiles"] as? [String],
				let file = files.first,
				let image = bundle.image(forResource: file)
			else {
				return nil
			}
			return image
		}
	}

//	func getIcons() -> [NSImage]? {
//		guard
//			let url,
//			let bundle = Bundle(url: url),
//			let infoDictionary = bundle.infoDictionary
//		else {
//			return nil
//		}
//
//		return Self.bundleSearchPaths.flatMap { path -> [NSImage] in
//			switch Self.recurse(dictionary: infoDictionary, remainingPath: path) {
//				case let iconName as String:
//					if let image = bundle.image(forResource: iconName) {
//						[image]
//					} else {
//						[]
//					}
//				case let iconNames as [String]:
//					iconNames.compactMap(bundle.image(forResource:))
//				default:
//					[]
//			}
//		}
//	}
}

// MARK: - Constants

// private extension Application {
//	/// The search paths for app icons in a bundle's info dictionary.
//	/// The last element is expected to have the value of `String` or `[String]`.
//	static let bundleSearchPaths: [[String]] = [
//		["CFBundleIconName"],
//		["CFBundleIconFile"],
//		["CFBundleIcons", "CFBundlePrimaryIcon", "CFBundleIconName"], // unoptimized, i know...
//		["CFBundleIcons", "CFBundlePrimaryIcon", "CFBundleIconFiles"],
//	]
// }

// MARK: - Utility

// private extension Application {
//	static func getValue<Path>(in dictionary: borrowing [String: Any], at path: Path) -> Any? where
//		Path: Collection<String>,
//		Path.Index: ExpressibleByIntegerLiteral
//	{
//		switch path.count {
//			case 0:
//				nil
//			case 1:
//				dictionary[path[0]]
//			default:
//				if let innerDictionary = dictionary[path[0]] as? [String: Any] {
//					getValue(in: innerDictionary, at: path.dropFirst())
//				} else {
//					nil
//				}
//		}
//	}
// }
