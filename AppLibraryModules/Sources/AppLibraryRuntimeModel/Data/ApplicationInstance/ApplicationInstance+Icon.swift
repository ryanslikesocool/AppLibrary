import AppKit
import AppLibraryCommon
import AppLibraryStorage
import BundleToolbox
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

			func work() -> (String, NSImage)? {
				Self.bundleImageSearchPaths
					.lazy
					.compactMap { path -> (String, NSImage)? in
						guard
							let value: Any = try? bundle.object(forInfoDictionaryKey: path),
							let result = Self.unwrapDictionaryValue(in: bundle, value)
						else {
							return nil
						}

						return (String(describing: path), result)
					}
					.first
			}
		}
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
	nonisolated(unsafe) static let bundleImageSearchPaths: [PartialInfoDictionaryObject<Bundle>] = [
		PartialInfoDictionaryObject(.cfBundleIconName),

		PartialInfoDictionaryObject(.cfBundleIconFile),

		PartialInfoDictionaryObject(
			.cfBundleIcons
				.appending(.cfBundlePrimaryIcon)
				.appending(.cfBundleIconName)
		),

		PartialInfoDictionaryObject(
			.cfBundleIcons
				.appending(.cfBundlePrimaryIcon)
				.appending(.cfBundleIconFiles)
		),
	]
}
