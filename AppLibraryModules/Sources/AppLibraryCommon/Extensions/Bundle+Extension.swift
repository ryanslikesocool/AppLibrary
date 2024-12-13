import Foundation

public extension Bundle {
	subscript<Key>(key: Key.Type) -> Key.Value where
		Key: BundleKey
	{
		get throws {
			guard let bundleValue = object(forInfoDictionaryKey: Key.key) else {
				throw CommonError.unexpectedNil
			}
			guard let safeValue = bundleValue as? Key.Value else {
				throw CommonError.castFailure(from: bundleValue, to: Key.Value.self)
			}
			return safeValue
		}
	}
}

// MARK: - BundleKey

public extension Bundle {
	// MARK: CFBundleName

	var cfBundleName: String {
		get throws {
			try self[__Key_cfBundleName.self]
		}
	}

	private enum __Key_cfBundleName: BundleKey {
		public typealias Value = String

		public static var key: String { kCFBundleNameKey as String }
	}

	// MARK: CFBundleShortVersionString

	var cfBundleShortVersionString: String {
		get throws {
			try self[__Key_cfBundleShortVersionString.self]
		}
	}

	private enum __Key_cfBundleShortVersionString: BundleKey {
		public typealias Value = String

		public static let key: String = "CFBundleShortVersionString"
	}

	// MARK: CFBundleVersionString

	var cfBundleVersionString: String {
		get throws {
			try self[__Key_cfBundleVersionString.self]
		}
	}

	private enum __Key_cfBundleVersionString: BundleKey {
		public typealias Value = String

		public static var key: String { kCFBundleVersionKey as String }
	}

	// MARK: NSHumanReadableCopyright

	@available(macOS 10.0, *)
	@available(iOS, unavailable)
	@available(tvOS, unavailable)
	@available(watchOS, unavailable)
	@available(macCatalyst, unavailable)
	@available(visionOS, unavailable)
	var nsHumanReadableCopyright: String {
		get throws {
			try self[__Key_nsHumanReadableCopyright.self]
		}
	}

	@available(macOS 10.0, *)
	@available(iOS, unavailable)
	@available(tvOS, unavailable)
	@available(watchOS, unavailable)
	@available(macCatalyst, unavailable)
	@available(visionOS, unavailable)
	private enum __Key_nsHumanReadableCopyright: BundleKey {
		public typealias Value = String

		public static let key: String = "NSHumanReadableCopyright"
	}
}