import AppKit
import BundleToolbox

public extension NSApplication {
	var appName: String {
		(try? Bundle.main.object(forInfoDictionaryKey: .cfBundleName))
			?? ProcessInfo.processInfo.processName
	}

	var appVersion: String? {
		let bundle = Bundle.main

		guard let shortVersion = try? bundle.object(forInfoDictionaryKey: .cfBundleShortVersionString) else {
			return nil
		}

		return if let version = try? bundle.object(forInfoDictionaryKey: .cfBundleVersion) {
			"\(shortVersion) (\(version))"
		} else {
			shortVersion
		}
	}
}
