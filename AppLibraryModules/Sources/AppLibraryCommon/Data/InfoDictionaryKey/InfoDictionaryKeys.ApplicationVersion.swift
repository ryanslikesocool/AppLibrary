import BundleToolbox
import Foundation

public extension InfoDictionaryKeys {
	/// ## Topics
	/// ### Convenience
	/// - ``InfoDictionaryObject/applicationVersion(includeBundleVersion:)``
	struct ApplicationVersion: InfoDictionaryObject {
		/// If `true`, ``process(_:)`` appends the value retrieved by ``InfoDictionaryKeys/CFBundleVersion``, surrounded by parentheses.
		private let includeBundleVersion: Bool

		/// - Parameter includeBundleVersion: If `true`, ``process(_:)`` appends the value retrieved by ``InfoDictionaryKeys/CFBundleVersion``, surrounded by parentheses.
		public init(includeBundleVersion: Bool = true) {
			self.includeBundleVersion = includeBundleVersion
		}

		public func process(_ input: Bundle) throws -> String {
			let shortVersion = try input.object(forInfoDictionaryKey: .cfBundleShortVersionString)

			if includeBundleVersion {
				let bundleVersion = try input.object(forInfoDictionaryKey: .cfBundleVersion)
				return "\(shortVersion) (\(bundleVersion))"
			} else {
				return shortVersion
			}
		}
	}
}

// MARK: - Convenience

public extension InfoDictionaryObject where
	Self == InfoDictionaryKeys.ApplicationVersion
{
	/// The app's version number, optionally including the build number.
	///
	/// The primary app version is retrieved from the given bundle's ``InfoDictionaryKeys/CFBundleShortVersionString``
	/// - Parameter includeBundleVersion: If `true`, appends the value retrieved by ``InfoDictionaryKeys/CFBundleVersion``, surrounded by parentheses.
	///
	/// ## See Also
	/// - ``InfoDictionaryKeys/ApplicationVersion``
	static func applicationVersion(includeBundleVersion: Bool = true) -> Self {
		Self(includeBundleVersion: includeBundleVersion)
	}
}
