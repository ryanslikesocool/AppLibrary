import AppKit

public extension NSApplication {
	var appName: String {
		(try? Bundle.main.cfBundleName) ?? ProcessInfo.processInfo.processName
	}

	var appVersion: String? {
		let bundle = Bundle.main

		guard let shortVersion = try? bundle.cfBundleShortVersionString else {
			return nil
		}

		return if let version = try? bundle.cfBundleVersionString {
			"\(shortVersion) (\(version))"
		} else {
			shortVersion
		}
	}
}
