import AppKit

public extension NSApplication {
	var appName: String {
		Bundle.main.bundleName ?? ProcessInfo.processInfo.processName
	}

	var appVersion: String? {
		let bundle = Bundle.main

		guard let shortVersion = bundle.bundleShortVersionString else {
			return nil
		}

		return if let version = bundle.bundleVersionString {
			"\(shortVersion) (\(version))"
		} else {
			shortVersion
		}
	}
}
