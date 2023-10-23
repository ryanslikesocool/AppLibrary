import AppKit

public enum AppLibraryInformation {
	private static var infoDictionary: [String: Any]? { Bundle.main.infoDictionary }

	public static var bundleIdentifier: String! { Bundle.main.bundleIdentifier }

	public static var appName: String { infoDictionary?["CFBundleName"] as? String ?? ProcessInfo.processInfo.processName }

	public static var appVersion: String? {
		guard let version = infoDictionary?["CFBundleShortVersionString"] as? String else {
			return nil
		}

		if let build = infoDictionary?["CFBundleVersion"] as? String {
			return "\(version) (\(build))"
		} else {
			return "\(version)"
		}
	}

	public static var copyright: String? {
		infoDictionary?["NSHumanReadableCopyright"] as? String
	}

	/// Format the copyright with the current year.
	/// This assumes the copyright string in `Info.plist` is in the format "`© YYYY Organization`"
	public static var currentCopyright: String? {
		guard let copyright else {
			return nil
		}

		var components = copyright.components(separatedBy: " ")
		guard let startYear = Int(components[1]) else { // start year must be formatted as Int
			return copyright
		}

		let currentYear: Int = Calendar(identifier: .gregorian).component(.year, from: Date())

		guard startYear != currentYear else {
			return copyright
		}

		components[1] = "\(components[1]) - \(currentYear.description)"

		return components.joined(separator: " ")
	}

	public static var appIcon: NSImage {
		NSApp.applicationIconImage
	}
}
