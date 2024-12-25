import Foundation

public extension Bundle {
	func object<Key>(forInfoDictionaryKey key: Key.Type) -> Key.Value? where
		Key: BundleInfoDictionaryKey
	{
		Key.process(infoDictionaryObject: object(forInfoDictionaryKey: Key.infoDictionaryKey))
	}

	func objects<each Key>(forInfoDictionaryKeys keys: repeat (each Key).Type) -> (repeat (each Key).Value?) where
		repeat each Key: BundleInfoDictionaryKey
	{
		(repeat object(forInfoDictionaryKey: each keys))
	}
}

// MARK: - BundleKey

public extension Bundle {
	// MARK: cfBundleName

	var cfBundleName: String? {
		object(forInfoDictionaryKey: __Key_cfBundleName.self)
	}

	private enum __Key_cfBundleName: BundleInfoDictionaryKey {
		public typealias Value = String

		public static var infoDictionaryKey: String { kCFBundleNameKey as String }
	}

	// MARK: cfBundleShortVersionString

	var cfBundleShortVersionString: String? {
		object(forInfoDictionaryKey: __Key_cfBundleShortVersionString.self)
	}

	private enum __Key_cfBundleShortVersionString: BundleInfoDictionaryKey {
		public typealias Value = String

		public static let infoDictionaryKey: String = "CFBundleShortVersionString"
	}

	// MARK: cfBundleVersionString

	var cfBundleVersionString: String? {
		object(forInfoDictionaryKey: __Key_cfBundleVersionString.self)
	}

	private enum __Key_cfBundleVersionString: BundleInfoDictionaryKey {
		public typealias Value = String

		public static var infoDictionaryKey: String { kCFBundleVersionKey as String }
	}
}

@available(macOS 10.0, *)
public extension Bundle {
	// MARK: nsHumanReadableCopyright

	var nsHumanReadableCopyright: String? {
		object(forInfoDictionaryKey: __Key_nsHumanReadableCopyright.self)
	}

	private enum __Key_nsHumanReadableCopyright: BundleInfoDictionaryKey {
		public typealias Value = String

		public static let infoDictionaryKey: String = "NSHumanReadableCopyright"
	}
}
