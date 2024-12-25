import AppKit

public extension NSApplication {
	var appName: String {
		Bundle.main.cfBundleName ?? ProcessInfo.processInfo.processName
	}

	var appVersion: String? {
		let bundle = Bundle.main

		guard let shortVersion = bundle.cfBundleShortVersionString else {
			return nil
		}

		return if let version = bundle.cfBundleVersionString {
			"\(shortVersion) (\(version))"
		} else {
			shortVersion
		}
	}
}
