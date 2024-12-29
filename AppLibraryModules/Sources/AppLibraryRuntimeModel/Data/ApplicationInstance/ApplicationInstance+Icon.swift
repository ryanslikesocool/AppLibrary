import AppKit
import AppLibraryCommon
import AppLibraryStorage
import DictionaryPath
import OSLog

extension ApplicationInstance {
	public func getIcon() -> NSImage? {
		guard
			let bundle,
			let (path, icon) = tryGetIcon(in: bundle)
		else {
			return nil
		}

		if FeatureFlag.Application.Icon.logSuccessfulResult {
			Self.logger.debug("""
			Found application icon:
			- Bundle Identifier: \(String(describing: bundle.bundleIdentifier))
			- Info Dictionary Path: \(path)
			""")
		}

		return icon

		func tryGetIcon(in bundle: Bundle) -> (String, NSImage)? {
			return if FeatureFlag.Application.Icon.measureTime {
				Measure.default.work("Get Application Icon", work: work)
			} else {
				work()
			}

			// TODO: Measure time elapsed for each implementation and only use shortest.

			func work() -> (String, NSImage)? {
				switch FeatureFlag.Application.Icon.implementation {
					case .manualPath: Self.getIconManualPath(in: bundle)
					case .recursivePath: Self.getIconRecursivePath(in: bundle)
					case .recursivePathTypeSafe: Self.getIconRecursivePathTypeSafe(in: bundle)
				}
			}
		}
	}

	private static func getIconManualPath(in bundle: Bundle) -> (String, NSImage)? {
		let functions: [([String]) -> NSImage?] = [
			try_depth1,
			try_depth1,
			try_CFBundleIcons_CFBundlePrimaryIcon_CFBundleIconName,
			try_CFBundleIcons_CFBundlePrimaryIcon_CFBundleIconFiles,
		]

		return zip(Self.bundleImageSearchPathKeys, functions)
			.lazy
			.compactMap { path, function -> (String, NSImage)? in
				guard let result = function(path) else {
					return nil
				}

				return (path.description, result)
			}
			.first

		func try_depth1(path: borrowing [String]) -> NSImage? {
			assert(path.count == 1)
			guard
				let value = bundle.object(forInfoDictionaryKey: path[0]) as? String,
				let image = bundle.image(forResource: value)
			else {
				return nil
			}
			return image
		}

		func try_CFBundleIcons_CFBundlePrimaryIcon_CFBundleIconName(path: borrowing [String]) -> NSImage? {
			assert(path.count == 3)
			guard
				let bundleIcons = bundle.object(forInfoDictionaryKey: path[0]) as? [String: Any],
				let primaryIcon = bundleIcons[path[1]] as? [String: Any],
				let iconName = primaryIcon[path[2]] as? String,
				let image = bundle.image(forResource: iconName)
			else {
				return nil
			}
			return image
		}

		func try_CFBundleIcons_CFBundlePrimaryIcon_CFBundleIconFiles(path: borrowing [String]) -> NSImage? {
			assert(path.count == 3)
			guard
				let bundleIcons = bundle.object(forInfoDictionaryKey: path[0]) as? [String: Any],
				let primaryIcon = bundleIcons[path[1]] as? [String: Any],
				let files = primaryIcon[path[2]] as? [String],
				let image = files
				.lazy
				.compactMap(bundle.image(forResource:))
				.first
			else {
				return nil
			}
			return image
		}
	}

	private static func getIconRecursivePath(in bundle: Bundle) -> (String, NSImage)? {
		guard let infoDictionary = bundle.infoDictionary else {
			return nil
		}

		return Self.bundleImageSearchPathKeys
			.lazy
			.compactMap { path -> (String, NSImage)? in
				guard let result = Self.unwrapDictionaryValue(in: bundle, infoDictionary.value(at: path)) else {
					return nil
				}

				return (path.description, result)
			}
			.first
	}

	private static func getIconRecursivePathTypeSafe(in bundle: Bundle) -> (String, NSImage)? {
		guard let infoDictionary = bundle.infoDictionary else {
			return nil
		}

		return Self.typeSafeBundleImageSearchPaths
			.lazy
			.compactMap { path -> (String, NSImage)? in
				guard let result = unwrapDictionaryValue(in: bundle, try? infoDictionary.value(at: path)) else {
					return nil
				}

				return (path.description, result)
			}
			.first
	}

	private static func unwrapDictionaryValue(in bundle: Bundle, _ value: Any?) -> NSImage? {
		switch value {
			case let iconName as String:
				bundle.image(forResource: iconName)
			case let iconNames as [String]:
				iconNames
					.lazy
					.compactMap(bundle.image(forResource:))
					.first
			default:
				nil
		}
	}
}

// MARK: - Constants

private extension ApplicationInstance {
	static let logger: Logger = Logger(category: "ApplicationIcon")

	// TODO: It might be possible to optimize icon search based on the app platform.
	// macOS apps, Mac Catalyst apps, and iOS apps running on Apple Silicon may use different icon paths.

	/// The search paths for app icons in a bundle's info dictionary.
	///
	/// ## Reference
	/// - [`CFBundleIconName`](https://developer.apple.com/documentation/bundleresources/information-property-list/cfbundleiconname)
	/// - [`CFBundleIconFile`](https://developer.apple.com/documentation/bundleresources/information-property-list/cfbundleiconfile)
	/// - [`CFBundleIconFiles`](https://developer.apple.com/documentation/bundleresources/information-property-list/cfbundleiconfiles)
	/// - [`CFBundleIcons`](https://developer.apple.com/documentation/bundleresources/information-property-list/cfbundleicons)
	/// - [`CFBundleSymbolName`](https://developer.apple.com/documentation/bundleresources/information-property-list/cfbundleicons/cfbundleprimaryicon/cfbundlesymbolname)
	static let bundleImageSearchPaths: [[(key: String, valueType: Any.Type)]] = [
		[("CFBundleIconName", String.self)],
		[("CFBundleIconFile", String.self)],
		[("CFBundleIcons", [String: Any].self), ("CFBundlePrimaryIcon", [String: Any].self), ("CFBundleIconName", String.self)],
		[("CFBundleIcons", [String: Any].self), ("CFBundlePrimaryIcon", [String: Any].self), ("CFBundleIconFiles", [String].self)],
	]

	nonisolated(unsafe) static let typeSafeBundleImageSearchPaths: [any DictionaryPathComponent] = [
		DictionaryPath(key: bundleImageSearchPaths[0][0].key, ofType: String.self),

		DictionaryPath(key: bundleImageSearchPaths[1][0].key, ofType: String.self),

		DictionaryPath(key: bundleImageSearchPaths[2][0].key, ofType: [String: Any].self)
			.appending(key: bundleImageSearchPaths[2][1].key, ofType: [String: Any].self)
			.appending(key: bundleImageSearchPaths[2][2].key, ofType: String.self),

		DictionaryPath(key: bundleImageSearchPaths[3][0].key, ofType: [String: Any].self)
			.appending(key: bundleImageSearchPaths[3][1].key, ofType: [String: Any].self)
			.appending(key: bundleImageSearchPaths[3][2].key, ofType: [String].self),
	]

	static let bundleImageSearchPathKeys: [[String]] = bundleImageSearchPaths.map { path in
		path.map(\.key)
	}
}
